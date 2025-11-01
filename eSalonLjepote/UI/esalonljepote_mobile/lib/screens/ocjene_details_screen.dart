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
  const OcjenaProizvodDetailsScreen({Key? key, this.ocjeneProizvoda})
      : super(key: key);

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
      debugPrint('Error fetching ocjene: $e');
    }
  }

  Future<void> _fetchKorisnici() async {
    try {
      var korisnikData = await _korisnikProvider.get();
      setState(() {
        _korisnik = korisnikData.result;
      });
    } catch (e) {
      debugPrint('Error fetching korisnici: $e');
    }
  }

  Future<void> _fetchProizvod() async {
    try {
      var proizvodData = await _proizvodProvider.get();
      setState(() {
        _proizvod = proizvodData.result;
      });
    } catch (e) {
      debugPrint('Error fetching proizvod: $e');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;
      final mutableFormData = Map<String, dynamic>.from(formData);

      mutableFormData['ocjena'] = int.tryParse(mutableFormData['ocjena'].toString()) ?? 0;
      mutableFormData['korisnikId'] = int.tryParse(mutableFormData['korisnikId'].toString()) ?? 0;
      mutableFormData['proizvodId'] = int.tryParse(mutableFormData['proizvodId'].toString()) ?? 0;

      try {
        String successMessage;
        if (widget.ocjeneProizvoda == null) {
          await _ocjeneProizvodaProvider.insert(OcjeneProizvoda.fromJson(mutableFormData));
          successMessage = 'Ocjena uspješno dodana.';
        } else {
          await _ocjeneProizvodaProvider.update(
            widget.ocjeneProizvoda!.ocjeneProizvodaId!,
            OcjeneProizvoda.fromJson(mutableFormData),
          );
          successMessage = 'Ocjena uspješno uređena.';
        }

        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Success'),
            content: Text(successMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
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
                child: const Text('Preporučeni proizvodi'),
              ),
            ],
          ),
        );
      } catch (e) {
        debugPrint('Error: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to save the evaluation. Please try again.'),
            ),
          );
        }
      }
    } else {
      final validationErrors = _formKey.currentState?.errors;
      debugPrint('Validation errors: $validationErrors');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Form validation failed. Please correct the errors and try again.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return MasterScreenWidget(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.1),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: media.height * 0.8),
            child: FormBuilder(
              key: _formKey,
              initialValue: _initialValue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dodaj ocjenu za proizvod',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_korisnikProvider.currentUser?.ime ?? 'Nepoznat korisnik'}, welcome to the section for adding your rate for doctors.',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Think good, and keep in mind that your rate affects future decisions.',
                  ),
                  const SizedBox(height: 16),
                  Offstage(
                    offstage: true,
                    child: FormBuilderTextField(
                      name: 'korisnikId',
                      initialValue: _korisnikProvider.currentUser?.korisnikId.toString(),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderDropdown<int>(
                    name: 'ocjena',
                    decoration: const InputDecoration(
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
                      _selectedProizvodId = value?.toString();
                    },
                    validator: (value) {
                      if (value == null) return 'Ovo polje je obavezno!';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    decoration: const InputDecoration(
                      labelText: "Razlog",
                      border: OutlineInputBorder(),
                    ),
                    name: "razlog",
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ovo polje je obavezno!';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  FormBuilderDropdown<String>(
                    name: 'proizvodId',
                    decoration: const InputDecoration(
                      labelText: 'Proizvod',
                      border: OutlineInputBorder(),
                    ),
                    items: _proizvod
                        ?.map((proizvod) => DropdownMenuItem<String>(
                              value: proizvod.proizvodId.toString(),
                              child: Text(proizvod.nazivProizvoda ?? ""),
                            ))
                        .toList() ?? [],
                    initialValue: _initialValue['proizvodId']?.toString(),
                    onChanged: (value) => _selectedProizvodId = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ovo polje je obavezno!';
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Dodaj'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
