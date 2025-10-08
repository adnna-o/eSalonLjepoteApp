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

class ZaposleniDetailsScreen extends StatefulWidget {
  final Zaposleni? zaposleni;
  final Function? onDataChanged;
  ZaposleniDetailsScreen({Key? key, this.zaposleni, this.onDataChanged})
      : super(key: key);

  @override
  State<ZaposleniDetailsScreen> createState() => _ZaposleniDetailsScreen();
}

class _ZaposleniDetailsScreen extends State<ZaposleniDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late ZaposleniProvider _zaposleniProvider;
  late KorisnikProvider _korisnikProvider;

  List<Zaposleni>? _zaposleni;
  List<Korisnik>? _korisnici;

  String? _selectedKorisniciId;
  String? _zaposleniIme;

  late Map<String, dynamic> _initialValue;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'korisnikId': widget.zaposleni?.korisnikId,
      'zaposleniId': widget.zaposleni?.zaposleniId,
      'zanimanje': widget.zaposleni?.zanimanje,
      'datumZaposlenja': widget.zaposleni?.datumZaposlenja,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _zaposleniProvider = context.read<ZaposleniProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();

    _fecthKorisnici();
    _fetchZaposleni();
  }

  Future<void> _fetchZaposleni() async {
    try {
      var zaposleniData = await _zaposleniProvider.get();
      setState(() {
        _zaposleni = zaposleniData.result;
        if (widget.zaposleni?.zaposleniId != null) {
          var zaposleni = _zaposleni?.firstWhere(
            (p) => p.zaposleniId == widget.zaposleni?.zaposleniId,
          );

          var korisnik = _korisnici?.firstWhere(
            (k) => k.korisnikId == zaposleni?.korisnikId,
          );
          _zaposleniIme = korisnik?.ime;
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
      _fetchZaposleni();
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
        if (widget.zaposleni == null) {
          await _zaposleniProvider.insert(Zaposleni.fromJson(mutableFormData));
          _showSuccessMessage('Appointment successfully added!');
        } else {
          await _zaposleniProvider.update(widget.zaposleni!.zaposleniId!,
              Zaposleni.fromJson(mutableFormData));
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
                  widget.zaposleni == null
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
                      labelText: 'Zaposleni',
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: "zanimanje",
                          decoration: InputDecoration(
                            labelText: "Zanimanje *",
                            labelStyle:
                                const TextStyle(color: Colors.orangeAccent),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.orangeAccent),
                            ),
                          ),
                          validator: (v) {
                            final val = (v ?? '').trim();
                            if (val.isEmpty) return 'Naziv je obavezan.';
                            if (val.length < 2)
                              return 'Naziv mora imati min. 2 znaka.';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Datum zaposlenja",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  name: "datumZaposlenja",
                  readOnly: true,
                  initialValue: _initialValue['datumZaposlenja'],
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (selectedDate != null) {
                      String formattedDate =
                          "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";

                      _formKey.currentState?.fields['datumZaposlenja']
                          ?.didChange(formattedDate);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno! Datum u formatu yyyy-MM-dd';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(widget.zaposleni == null ? 'Add' : 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.zaposleni != null
          ? "Appoitment: ${_zaposleniIme}"
          : "Appoitment details",
    );
  }
}
