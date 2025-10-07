import 'dart:convert';

import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/usluga.dart';
import 'package:esalonljepote_desktop/models/zaposleni.dart';
import 'package:esalonljepote_desktop/providers/klijenti_provider.dart';
import 'package:esalonljepote_desktop/providers/korisnik_provider.dart';
import 'package:esalonljepote_desktop/providers/termini_provider.dart';
import 'package:esalonljepote_desktop/providers/usluga_provider.dart';
import 'package:esalonljepote_desktop/providers/zaposleni_provider.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class KlijentiDetailsScreen extends StatefulWidget {
  final Klijenti? klijenti;
  final Function? onDataChanged;
  KlijentiDetailsScreen({Key? key, this.klijenti, this.onDataChanged})
      : super(key: key);

  @override
  State<KlijentiDetailsScreen> createState() => _KlijentiDetailsScreen();
}

class _KlijentiDetailsScreen extends State<KlijentiDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KlijentiProvider _klijentiProvider;
  late KorisnikProvider _korisnikProvider;

  List<Klijenti>? _klijenti;
  List<Korisnik>? _korisnici;

  String? _selectedKorisniciId;
  String? _klijentIme;

  late Map<String, dynamic> _initialValue;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'korisnikId': widget.klijenti?.korisnikId,
      'klijentId': widget.klijenti?.klijentId,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _klijentiProvider = context.read<KlijentiProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();


    _fecthKorisnici();
    _fetchKlijenti();
  }

  Future<void> _fetchKlijenti() async {
    try {
      var klijentData = await _klijentiProvider.get();
      setState(() {
        _klijenti = klijentData.result;
        if (widget.klijenti?.klijentId != null) {
          var klijent = _klijenti?.firstWhere(
            (p) => p.klijentId == widget.klijenti?.klijentId,
          );

          var korisnik = _korisnici?.firstWhere(
            (k) => k.korisnikId == klijent?.korisnikId,
          );
          _klijentIme = korisnik?.ime;
        }
      });
    } catch (e) {
      print('Error fetching klijent: $e');
    }
  }

 
  Future<void> _fecthKorisnici() async {
    try {
      var korisnikData = await _korisnikProvider.get();
      setState(() {
        _korisnici = korisnikData.result;
      });
      _fetchKlijenti();
    } catch (e) {
      print('Error fetching korisnik: $e');
    }
  }

 
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green[400],
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      final mutableFormData = Map<String, dynamic>.from(formData);

     /* if (mutableFormData['klijentId'] != null) {
        mutableFormData['klijentId'] =
            int.tryParse(mutableFormData['klijentId'] as String) ?? 0;
      }*/
     
      if (mutableFormData['korisnikId'] != null) {
        mutableFormData['korisnikId'] =
            int.tryParse(mutableFormData['korisnikId'] as String) ?? 0;
      }

      try {
        if (widget.klijenti == null) {
          await _klijentiProvider.insert(Klijenti.fromJson(mutableFormData));
          _showSuccessMessage('Appointment successfully added!');
        } else {
          await _klijentiProvider.update(
              widget.klijenti!.klijentId!, Klijenti.fromJson(mutableFormData));
          _showSuccessMessage('Appointment successfully updated!');
        }

        if (widget.onDataChanged != null) {
          widget.onDataChanged!();
        }

        Navigator.of(context).pop();
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save the term. Please try again.')),
        );
      }
    }
  }

  void _successDialogADD(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            initialValue: _initialValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.klijenti== null
                      ? 'Adding a new appointment'
                      : 'Updating appointment',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 16.0),
               
                FormBuilderDropdown<String>(
                    name: 'korisnikId',
                    decoration: InputDecoration(
                      labelText: 'Klijent',
                    ),
                    items: _korisnici?.map((klijent) {
                          var korisnik = _korisnici?.firstWhere(
                            (k) => k.korisnikId == klijent.korisnikId,
                          );

                          var displayText = korisnik != null
                              ? "${korisnik.ime} ${korisnik.prezime}"
                              : "Nepoznato";
                          return DropdownMenuItem<String>(
                            value: klijent.korisnikId.toString(),
                            child: Text(displayText),
                          );
                        }).toList() ??
                        [],
                    initialValue: _initialValue['korisnikId']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        _selectedKorisniciId = value;
                      });
                      print("Odabrani korisnikId: $_selectedKorisniciId");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
               
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(widget.klijenti == null ? 'Add' : 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.klijenti != null
          ? "Appoitment: ${_klijentIme}"
          : "Appoitment details",
    );
  }
}
