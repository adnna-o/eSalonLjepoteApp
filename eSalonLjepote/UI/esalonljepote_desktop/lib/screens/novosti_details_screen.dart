import 'dart:collection';
import 'dart:convert';

import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:esalonljepote_desktop/models/narudzba.dart';
import 'package:esalonljepote_desktop/models/novosti.dart';
import 'package:esalonljepote_desktop/models/placanje.dart';
import 'package:esalonljepote_desktop/models/proizvod.dart';
import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/usluga.dart';
import 'package:esalonljepote_desktop/models/zaposleni.dart';
import 'package:esalonljepote_desktop/providers/klijenti_provider.dart';
import 'package:esalonljepote_desktop/providers/korisnik_provider.dart';
import 'package:esalonljepote_desktop/providers/narudzba_provider.dart';
import 'package:esalonljepote_desktop/providers/novosti_provider.dart';
import 'package:esalonljepote_desktop/providers/placanje_provider.dart';
import 'package:esalonljepote_desktop/providers/proizvod_provider.dart';
import 'package:esalonljepote_desktop/providers/termini_provider.dart';
import 'package:esalonljepote_desktop/providers/usluga_provider.dart';
import 'package:esalonljepote_desktop/providers/zaposleni_provider.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NovostiDetailsScreen extends StatefulWidget {
  final Novosti? novosti;
  final Function? onDataChanged;
  NovostiDetailsScreen({Key? key, this.novosti, this.onDataChanged})
      : super(key: key);

  @override
  State<NovostiDetailsScreen> createState() => _NovostiDetailsScreen();
}

class _NovostiDetailsScreen extends State<NovostiDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;
  late NovostiProvider _novostiProvider;

  List<Korisnik>? korisnikResult;
  List<Novosti>? novostiResult;

  String? _selectedKorisnikId;

  late Map<String, dynamic> _initialValue;

  bool isLoading = false;

  @override
  void initState() {
    String todayFormatted =
        "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
    super.initState();
    _initialValue = {
      'novostiId': widget.novosti?.novostiId,
      'naziv': widget.novosti?.naziv,
      'opisNovisti': widget.novosti?.opisNovisti,
      'datumObjave': widget.novosti?.datumObjave ?? DateTime.now(),
      'korisnikId': widget.novosti?.korisnikId,
      'aktivna': widget.novosti?.aktivna,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _novostiProvider = context.read<NovostiProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();

    _fetchNovosti();
    _fecthKorisnici();
  }

  Future<void> _fetchNovosti() async {
    try {
      var novostiData = await _novostiProvider.get();
      setState(() {
        novostiResult = novostiData.result;
      });
    } catch (e) {
      print('Error fetching usluga: $e');
    }
  }

  Future<void> _fecthKorisnici() async {
    try {
      var korisnikData = await _korisnikProvider.get();
      setState(() {
        korisnikResult = korisnikData.result;
      });
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

      if (mutableFormData['korisnikId'] != null) {
        mutableFormData['korisnikId'] =
            int.tryParse(mutableFormData['korisnikId'] as String) ?? 0;
      }

      mutableFormData['aktivna'] = (mutableFormData['aktivna'] == true) ? 1 : 0;

      if (mutableFormData['datumObjave'] is DateTime) {
        mutableFormData['datumObjave'] =
            DateFormat('yyyy-MM-dd').format(mutableFormData['datumObjave']);
      }

      try {
        if (widget.novosti == null) {
          await _novostiProvider.insert(Novosti.fromJson(mutableFormData));
          _showSuccessMessage('Novosti uspjesno dodane!');
        } else {
          await _novostiProvider.update(
              widget.novosti!.novostiId!, Novosti.fromJson(mutableFormData));
          _showSuccessMessage('Novosti uspjesno uredjene');
        }

        if (widget.onDataChanged != null) {
          widget.onDataChanged!();
        }

        Navigator.of(context).pop();
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Greska u dodavanju nove novosti. Probajte opet.')),
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
                  widget.novosti == null
                      ? 'Dodaj nove novosti'
                      : 'Uredi novosti',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: "naziv",
                          decoration: InputDecoration(
                            labelText: "Naziv novosti*",
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
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: "opisNovisti",
                          decoration: InputDecoration(
                            labelText: "Opis novosti *",
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
                SizedBox(
                  height: 16,
                ),
                FormBuilderDateTimePicker(
                  name: 'datumObjave',
                  decoration: InputDecoration(
                    labelText: "Datum objave",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  inputType: InputType.date,
                  format: DateFormat('yyyy-MM-dd'),
                  initialValue: _initialValue['datumObjave'] as DateTime?,
                  validator: (value) {
                    if (value == null) return 'Odaberite datum objave.';
                    return null;
                  },
                ),
                SizedBox(height: 16),
                korisnikResult != null
                    ? FormBuilderDropdown<String>(
                        name: 'korisnikId',
                        decoration: InputDecoration(labelText: 'Korisnik'),
                        items: korisnikResult!.map((klijent) {
                          return DropdownMenuItem<String>(
                            value: klijent.korisnikId.toString(),
                            child: Text("${klijent.ime} ${klijent.prezime}"),
                          );
                        }).toList(),
                        initialValue: (_initialValue['korisnikId'] != null &&
                                korisnikResult!.any((k) =>
                                    k.korisnikId ==
                                    _initialValue['korisnikId']))
                            ? _initialValue['korisnikId'].toString()
                            : null,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Ovo polje je obavezno!';
                          return null;
                        },
                      )
                    : CircularProgressIndicator(), // ili SizedBox()

                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderCheckbox(
                          name: 'aktivna',
                          initialValue: (_initialValue['aktivna'] == 1 ||
                              _initialValue['aktivna'] == true),
                          title: const Text('Aktivna'),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(widget.novosti == null ? 'Add' : 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.novosti != null
          ? "Novosti: ${widget.novosti!.naziv}"
          : "Detalji novosti",
    );
  }
}
