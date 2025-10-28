import 'package:esalonljepote_mobile/models/korisnik.dart';
import 'package:esalonljepote_mobile/models/ocjene_proizvoda.dart';
import 'package:esalonljepote_mobile/models/proizvod.dart';
import 'package:esalonljepote_mobile/providers/korisnik_provider.dart';
import 'package:esalonljepote_mobile/providers/ocjene_proizvoda_provider.dart';
import 'package:esalonljepote_mobile/providers/proizvod_provider.dart';
import 'package:esalonljepote_mobile/screens/preporuceni_proizvodi_screen.dart';
import 'package:esalonljepote_mobile/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class OcjenaProizvodDetailsScreen extends StatefulWidget {
  final OcjeneProizvoda? ocjeneProizvoda;
  OcjenaProizvodDetailsScreen({Key? key, this.ocjeneProizvoda}) : super(key: key);

  @override
  State<OcjenaProizvodDetailsScreen> createState() =>
      _OcjenaProizvodDetailsScreen();
}

class _OcjenaProizvodDetailsScreen extends State<OcjenaProizvodDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;
  late OcjeneProizvodaProvider _ocjeneProizvodaProvider;
  late ProizvodProvider _proizvodProvider;

  List<Proizvod>? _proizvod;
  List<OcjeneProizvoda>? _ocjeneProizvoda;
  List<Korisnik>? _korisnik;

  String? _selectedKorisnikId;
  String? _selectedProizvodId;

  late Map<String, dynamic> _initialValue;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'ocjena': widget.ocjeneProizvoda?.ocjena,
      'opis': widget.ocjeneProizvoda?.opis,
      'korisnikId': widget.ocjeneProizvoda?.korisnikId,
      'proizvodId': widget.ocjeneProizvoda?.proizvodId,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ocjeneProizvodaProvider = context.read<OcjeneProizvodaProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _proizvodProvider = context.read<ProizvodProvider>();

    var currentUser = _korisnikProvider.currentUser;
    print(currentUser);

    if (currentUser != null) {
      _initialValue['korisnikId'] = currentUser.korisnikId.toString();
    }

    _fetchOcjene();
    _fetchKorisnici();
    _fetchProizvod();
  }

  Future<void> _fetchOcjene() async {
    try {
      var ocjenaProizvodData = await _ocjeneProizvodaProvider.get();
      setState(() {
        _ocjeneProizvoda = ocjenaProizvodData.result;
      });
    } catch (e) {
      print('Error fetching ocjene: $e');
    }
  }

  Future<void> _fetchKorisnici() async {
    try {
      var korisnikData = await _korisnikProvider.get();
      setState(() {
        _korisnik = korisnikData.result;
      });
    } catch (e) {
      print('Error fetching korisnici: $e');
    }
  }

  Future<void> _fetchProizvod() async {
    try {
      var proizvodData = await _proizvodProvider.get();
      setState(() {
        _proizvod = proizvodData.result;
      });
    } catch (e) {
      print('Error fetching doktori: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      final mutableFormData = Map<String, dynamic>.from(formData);

      if (mutableFormData['ocjena'] != null) {
        mutableFormData['ocjena'] = mutableFormData['ocjena'] is int
            ? mutableFormData['ocjena']
            : int.tryParse(mutableFormData['ocjena'].toString()) ?? 0;
      }

      if (mutableFormData['korisnikId'] != null) {
        mutableFormData['korisnikId'] = mutableFormData['korisnikId'] is int
            ? mutableFormData['korisnikId']
            : int.tryParse(mutableFormData['korisnikId'].toString()) ?? 0;
      }

      if (mutableFormData['proizvodId'] != null) {
        mutableFormData['proizvodId'] = mutableFormData['proizvodId'] is int
            ? mutableFormData['proizvodId']
            : int.tryParse(mutableFormData['proizvodId'].toString()) ?? 0;
      }

      try {
        String successMessage;

        if (widget.ocjeneProizvoda == null) {
          await _ocjeneProizvodaProvider
              .insert(OcjeneProizvoda.fromJson(mutableFormData));
          successMessage = 'Ocjena uspješno dodana.';
        } else {
          if (widget.ocjeneProizvoda!.ocjeneProizvodaId == null) {
            throw Exception('Ocjena ID is null');
          }
          await _ocjeneProizvodaProvider.update(
            widget.ocjeneProizvoda!.ocjeneProizvodaId!,
            OcjeneProizvoda.fromJson(mutableFormData),
          );
          successMessage = 'Ocjena uspješno uređena.';
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text(successMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PreporuceniProizvodiScreen(),
                    ),
                  );
                },
                child: Text('Recommended doctors'),
              ),
            ],
          ),
        );
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save the evaluation. Please try again.'),
          ),
        );
      }
    } else {
      final validationErrors = _formKey.currentState?.errors;
      print('Validation errors: $validationErrors');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Form validation failed. Please correct the errors and try again.',
          ),
        ),
      );
    }
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
                  'Add proizvod rating',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
                Text(
                  '${_korisnikProvider.currentUser?.ime ?? 'Nepoznat korisnik'}, welcome to the section for adding Your rate for doctors.',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                    'Think good, and keep on your mind that on your rate depends future of doctors and patients opinion.'),
                Offstage(
                  offstage: true,
                  child: FormBuilderTextField(
                    name: 'korisnikId',
                    initialValue:
                        _korisnikProvider.currentUser?.korisnikId.toString(),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Korisnik (ID)',
                      border: OutlineInputBorder(),
                      hintText: "Nepoznat korisnik",
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                FormBuilderDropdown<int>(
                  name: 'ocjena',
                  decoration: InputDecoration(
                    labelText: 'Rating',
                    border: OutlineInputBorder(),
                  ),
                  items: List.generate(5, (index) {
                    int rating = index + 1;
                    return DropdownMenuItem<int>(
                      value: rating,
                      child: Text(rating.toString()),
                    );
                  }),
                  initialValue: _initialValue['ocjena'],
                  onChanged: (value) {
                    setState(() {
                      _selectedProizvodId = value?.toString();
                    });
                    print("Odabrana ocjena: $value");
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderTextField(
                  decoration: InputDecoration(
                    labelText: "Reason",
                    border: OutlineInputBorder(),
                  ),
                  name: "razlog",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                FormBuilderDropdown<String>(
                  name: 'proizvodId',
                  decoration: InputDecoration(
                    labelText: 'Doctor',
                  ),
                  items: _proizvod
                          ?.map((doktor) => DropdownMenuItem<String>(
                                value: doktor.proizvodId.toString(),
                                child: Text(doktor.nazivProizvoda ?? ""),
                              ))
                          .toList() ??
                      [],
                  initialValue: _initialValue['proizvodId']?.toString(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProizvodId = value;
                    });
                    print("Odabrani doktorId: $_selectedProizvodId");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}