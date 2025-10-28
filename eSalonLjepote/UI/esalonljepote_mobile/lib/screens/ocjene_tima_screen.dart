import 'package:esalonljepote_mobile/models/korisnik.dart';
import 'package:esalonljepote_mobile/models/ocjene_proizvoda.dart';
import 'package:esalonljepote_mobile/models/proizvod.dart';
import 'package:esalonljepote_mobile/models/recenzije.dart';
import 'package:esalonljepote_mobile/models/search_result.dart';
import 'package:esalonljepote_mobile/providers/korisnik_provider.dart';
import 'package:esalonljepote_mobile/providers/ocjene_proizvoda_provider.dart';
import 'package:esalonljepote_mobile/providers/proizvod_provider.dart';
import 'package:esalonljepote_mobile/providers/recenzije_provider.dart';
import 'package:esalonljepote_mobile/screens/preporuceni_proizvodi_screen.dart';
import 'package:esalonljepote_mobile/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class OcjeneTimaScreen extends StatefulWidget {
  final Recenzije? recenzije;
  OcjeneTimaScreen({Key? key, this.recenzije}) : super(key: key);

  @override
  State<OcjeneTimaScreen> createState() => _OcjeneTimaScreen();
}

class _OcjeneTimaScreen extends State<OcjeneTimaScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;
  late RecenzijaProvider _recenzijaProvider;

  List<Recenzije>? _recenzije;
  SearchResult<Recenzije>? _recenzijaResult;

  List<Korisnik>? _korisnik;

  String? _selectedKorisnikId;

  late Map<String, dynamic> _initialValue;

  @override
  void initState() {
    super.initState();
    _initialValue = {
      'ocjena': widget.recenzije?.ocjena,
      'opisRecenzije': widget.recenzije?.opisRecenzije,
      'korisnikId': widget.recenzije?.korisnikId,
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _recenzijaProvider = context.read<RecenzijaProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();

    var currentUser = _korisnikProvider.currentUser;
    print(currentUser);

    if (currentUser != null) {
      _initialValue['korisnikId'] = currentUser.korisnikId.toString();
    }

    _fetchOcjene();
    _fetchKorisnici();
  }

  Future<void> _fetchOcjene() async {
    try {
      var recenzijeData = await _recenzijaProvider.get();
      setState(() {
        _recenzije = recenzijeData.result;
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

      try {
        String successMessage;

        if (widget.recenzije == null) {
          await _recenzijaProvider.insert(Recenzije.fromJson(mutableFormData));
          successMessage = 'Ocjena uspješno dodana.';
        } else {
          if (widget.recenzije!.recenzijeId == null) {
            throw Exception('Ocjena ID is null');
          }
          await _recenzijaProvider.update(
            widget.recenzije!.recenzijeId!,
            Recenzije.fromJson(mutableFormData),
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
                  _fetchOcjene();
                },
                child: Text('OK'),
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
                      _selectedKorisnikId = value?.toString();
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
                  name: "opisRecenzije",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ovo polje je obavezno!';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Add'),
                ),
                SizedBox(
                  height: 16,
                ),
                _buildDataListView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataListView() {
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();

    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Ocjene salona ')),
            DataColumn(label: Text('Opis recenzije')),
          ],
          rows: _recenzije?.map((Recenzije e) {
                return DataRow(cells: [
                  DataCell(Text(e.ocjena.toString())),
                  DataCell(Text(e.opisRecenzije.toString())),
                ]);
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
