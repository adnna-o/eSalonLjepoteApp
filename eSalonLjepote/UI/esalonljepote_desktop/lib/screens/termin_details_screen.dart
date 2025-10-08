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

class TerminDetailsScreen extends StatefulWidget {
  final Termini? termin;
  final Function? onDataChanged;
  TerminDetailsScreen({Key? key, this.termin, this.onDataChanged})
      : super(key: key);

  @override
  State<TerminDetailsScreen> createState() => _TerminDetailsScreen();
}

class _TerminDetailsScreen extends State<TerminDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late TerminiProvider _terminProvider;
  late KlijentiProvider _klijentiProvider;
  late KorisnikProvider _korisnikProvider;
  late ZaposleniProvider _zaposleniProvider;
  late UslugaProvider _uslugaProvider;

  List<Klijenti>? _klijenti;
  List<Korisnik>? _korisnici;
  List<Termini>? _termin;
  List<Usluga>? _usluge;
  List<Zaposleni>? _zaposleni;

  String? _selectedKlijentId;
  String? _selectedUslugaId;
  String? _selectedZaposleniId;
  String? _klijentIme;
  String? _zaposleniIme;

  late Map<String, dynamic> _initialValue;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'terminId': widget.termin?.terminId,
      'vrijemeTermina': widget.termin?.vrijemeTermina,
      'datumTermina': widget.termin?.datumTermina,
      'klijentId': widget.termin?.klijentId,
      'zaposleniId': widget.termin?.zaposleniId,
      'uslugaId': widget.termin?.uslugaId,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _terminProvider = context.read<TerminiProvider>();
    _uslugaProvider = context.read<UslugaProvider>();
    _zaposleniProvider = context.read<ZaposleniProvider>();
    _klijentiProvider = context.read<KlijentiProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();

    _fecthKorisnici();

    _fetchUsluga();
  }

  Future<void> _fetchKlijenti() async {
    try {
      var klijentData = await _klijentiProvider.get();
      setState(() {
        _klijenti = klijentData.result;
        if (widget.termin?.klijentId != null) {
          var klijent = _klijenti?.firstWhere(
            (p) => p.klijentId == widget.termin?.klijentId,
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

  Future<void> _fetchZaposleni() async {
    try {
      var zaposleniData = await _zaposleniProvider.get();
      setState(() {
        _zaposleni = zaposleniData.result;

        if (widget.termin?.zaposleniId != null) {
          var zaposleni = _zaposleni?.firstWhere(
            (p) => p.zaposleniId == widget.termin?.zaposleniId,
          );

          var korisnik = _korisnici?.firstWhere(
            (k) => k.korisnikId == zaposleni?.korisnikId,
          );
          _zaposleniIme = korisnik?.ime;
        }
      });
    } catch (e) {
      print('Error fetching zaposleni: $e');
    }
  }

  Future<void> _fetchUsluga() async {
    try {
      var uslugaData = await _uslugaProvider.get();
      setState(() {
        _usluge = uslugaData.result;
      });
    } catch (e) {
      print('Error fetching usluga: $e');
    }
  }

  Future<void> _fecthKorisnici() async {
    try {
      var korisnikData = await _korisnikProvider.get();
      setState(() {
        _korisnici = korisnikData.result;
      });
      _fetchKlijenti();
      _fetchZaposleni();
    } catch (e) {
      print('Error fetching korisnik: $e');
    }
  }

  Future<void> _fetchTermini() async {
    try {
      var terminData = await _terminProvider.get();
      setState(() {
        _termin = terminData.result;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
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

      if (mutableFormData['klijentId'] != null) {
        mutableFormData['klijentId'] =
            int.tryParse(mutableFormData['klijentId'] as String) ?? 0;
      }
      if (mutableFormData['zaposleniId'] != null) {
        mutableFormData['zaposleniId'] =
            int.tryParse(mutableFormData['zaposleniId'] as String) ?? 0;
      }
      if (mutableFormData['uslugaId'] != null) {
        mutableFormData['uslugaId'] =
            int.tryParse(mutableFormData['uslugaId'] as String) ?? 0;
      }

      try {
        if (widget.termin == null) {
          await _terminProvider.insert(Termini.fromJson(mutableFormData));
          _showSuccessMessage('Appointment successfully added!');
        } else {
          await _terminProvider.update(
              widget.termin!.terminId!, Termini.fromJson(mutableFormData));
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
                  widget.termin == null
                      ? 'Adding a new appointment'
                      : 'Updating appointment',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Datum termina",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  name: "datumTermina",
                  readOnly: true,
                  initialValue: _initialValue['datumTermina'],
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

                      _formKey.currentState?.fields['datumTermina']
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
                SizedBox(height: 16),
                FormBuilderTextField(
                    decoration: InputDecoration(
                      labelText: "Vrijeme termina",
                      border: OutlineInputBorder(),
                    ),
                    name: "vrijemeTermina",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                    name: 'klijentId',
                    decoration: InputDecoration(
                      labelText: 'Klijent',
                    ),
                    items: _klijenti?.map((klijent) {
                          var korisnik = _korisnici?.firstWhere(
                            (k) => k.korisnikId == klijent.korisnikId,
                          );

                          var displayText = korisnik != null
                              ? "${korisnik.ime} ${korisnik.prezime}"
                              : "Nepoznato";
                          return DropdownMenuItem<String>(
                            value: klijent.klijentId.toString(),
                            child: Text(displayText),
                          );
                        }).toList() ??
                        [],
                    initialValue: _initialValue['klijentId']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        _selectedKlijentId = value;
                      });
                      print("Odabrani klijentId: $_selectedKlijentId");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                    name: 'zaposleniId',
                    decoration: InputDecoration(
                      labelText: 'Zaposleni',
                    ),
                    items: _zaposleni?.map((zaposleni) {
                          var korisnik = _korisnici?.firstWhere(
                            (k) => k.korisnikId == zaposleni.korisnikId,
                          );

                          var displayText = korisnik != null
                              ? "${korisnik.ime} ${korisnik.prezime}"
                              : "Nepoznato";
                          return DropdownMenuItem<String>(
                            value: zaposleni.zaposleniId.toString(),
                            child: Text(displayText),
                          );
                        }).toList() ??
                        [],
                    initialValue: _initialValue['zaposleniId']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        _selectedKlijentId = value;
                      });
                      print("Odabrani zaposleniId: $_selectedZaposleniId");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                FormBuilderDropdown<String>(
                    name: 'uslugaId',
                    decoration: InputDecoration(
                      labelText: 'Usluga',
                    ),
                    items: _usluge
                            ?.map((usluga) => DropdownMenuItem<String>(
                                  value: usluga.uslugaId.toString(),
                                  child: Text(usluga.nazivUsluge ?? ""),
                                ))
                            .toList() ??
                        [],
                    initialValue: _initialValue['uslugaId']?.toString(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUslugaId = value;
                      });
                      print("Odabrani usluga: $_selectedUslugaId");
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ovo polje je obavezno!';
                      }
                      return null;
                    }),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(widget.termin == null ? 'Add' : 'Save'),
                ),
              ],
            ),
          ),
        ),
      ),
      title: widget.termin != null
          ? "Appoitment: ${_klijentIme}"
          : "Appoitment details",
    );
  }
}
