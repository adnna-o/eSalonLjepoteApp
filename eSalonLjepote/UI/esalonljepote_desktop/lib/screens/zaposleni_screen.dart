import 'dart:async';
import 'dart:convert';
import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:esalonljepote_desktop/models/narudzba.dart';
import 'package:esalonljepote_desktop/models/proizvod.dart';
import 'package:esalonljepote_desktop/models/search_result.dart';
import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/usluga.dart';
import 'package:esalonljepote_desktop/models/zaposleni.dart';
import 'package:esalonljepote_desktop/providers/klijenti_provider.dart';
import 'package:esalonljepote_desktop/providers/korisnik_provider.dart';
import 'package:esalonljepote_desktop/providers/narudzba_provider.dart';
import 'package:esalonljepote_desktop/providers/proizvod_provider.dart';
import 'package:esalonljepote_desktop/providers/termini_provider.dart';
import 'package:esalonljepote_desktop/providers/usluga_provider.dart';
import 'package:esalonljepote_desktop/providers/zaposleni_provider.dart';
import 'package:esalonljepote_desktop/screens/klijent_details_screen.dart';
import 'package:esalonljepote_desktop/screens/proizvod_datails_screen.dart';
import 'package:esalonljepote_desktop/screens/termin_details_screen.dart';
import 'package:esalonljepote_desktop/screens/zaposleni_details_screen.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ZaposleniScreen extends StatefulWidget {
  Zaposleni? zaposleni;
  ZaposleniScreen({Key? key, this.zaposleni}) : super(key: key);

  @override
  State<ZaposleniScreen> createState() => _ZaposleniScreen();
}

class _ZaposleniScreen extends State<ZaposleniScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;
  late ZaposleniProvider _zaposleniProvider;

  SearchResult<Zaposleni>? zaposleniResult;
  SearchResult<Korisnik>? korisnikResult;

  TextEditingController _imeZaposlenikaController = TextEditingController();
  TextEditingController _prezimeZaposlenikaController = TextEditingController();
  TextEditingController _uslugaZaposlenikaController = TextEditingController();

  bool searchExecuted = false;
  Timer? _debounce;

//Inicijalizacija providera
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _zaposleniProvider = context.read<ZaposleniProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();

    _fetchZaposleni();
    _fecthKorisnici();
  }

  Future<void> _fetchZaposleni() async {
    var zaposleniData = await _zaposleniProvider.get();

    setState(() {
      zaposleniResult = zaposleniData;
    });
  }

  Future<void> _fecthKorisnici() async {
    var korisnikData = await _korisnikProvider.get();

    setState(() {
      korisnikResult = korisnikData;
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      var data = await _zaposleniProvider.get(filter: {
        'imeZaposlenika': _imeZaposlenikaController.text.trim(),
        'prezimeZaposlenika': _prezimeZaposlenikaController.text.trim(),
        'zanimanje': _uslugaZaposlenikaController.text.trim(),
      });
      setState(() {
        zaposleniResult = data;
      });
    });
  }

  Future<void> _searchData() async {
    var filter = {
      'imeZaposlenika': _imeZaposlenikaController.text,
      'prezimeZaposlenika': _prezimeZaposlenikaController.text,
      'zanimanje': _uslugaZaposlenikaController.text,
    };

    var data = await _zaposleniProvider.get(filter: filter);

    setState(() {
      zaposleniResult = data;
      searchExecuted = true;
    });
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_search,
                      color: const Color.fromARGB(255, 34, 78, 57)),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Ime klijenta",
                        labelStyle: TextStyle(
                            color: const Color.fromARGB(255, 34, 78, 57)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 34, 78, 57)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 34, 78, 57)),
                        ),
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        filled: true,
                      ),
                      controller: _imeZaposlenikaController,
                      onChanged: (value) => _onSearchChanged(),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Prezime klijenta",
                        labelStyle: TextStyle(
                            color: const Color.fromARGB(255, 34, 78, 57)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 34, 78, 57)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 34, 78, 57)),
                        ),
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        filled: true,
                      ),
                      controller: _prezimeZaposlenikaController,
                      onChanged: (value) => _onSearchChanged(),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Naziv usluge klijenta",
                        labelStyle: TextStyle(
                            color: const Color.fromARGB(255, 34, 78, 57)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 34, 78, 57)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: const Color.fromARGB(255, 34, 78, 57)),
                        ),
                        fillColor: const Color.fromARGB(255, 237, 237, 237),
                        filled: true,
                      ),
                      controller: _uslugaZaposlenikaController,
                      onChanged: (value) => _onSearchChanged(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _searchData,
                child: Text("Search"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/homepage.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildSearch(),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(child: _buildDataListView()),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ZaposleniDetailsScreen(
                      onDataChanged: _fetchZaposleni,
                    ),
                  ),
                );
                if (result != null) {
                  _fetchZaposleni();
                }
              },
              child: Text("Dodaj novog zaposlenika!"),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshZaposleni() async {
    var klijentData = await _zaposleniProvider.get();

    setState(() {
      zaposleniResult = klijentData;
    });
  }

  Widget _buildDataListView() {
    if (zaposleniResult == null || zaposleniResult!.result.isEmpty) {
      return Center(
        child: Text("Nema zaposlenog za prikaz"),
      );
    }

    return GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 9 / 3,
        ),
        itemCount: zaposleniResult!.result.length,
        itemBuilder: (context, index) {
          Zaposleni e = zaposleniResult!.result[index];
          var korisnik = korisnikResult?.result.firstWhere(
            (k) => k.korisnikId == e.korisnikId,
            orElse: () => Korisnik(ime: "Nepoznato", prezime: "", slika: ""),
          );
          return Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ZaposleniDetailsScreen(
                      onDataChanged: _fetchZaposleni,
                      zaposleni: e,
                    ),
                  ),
                );
                if (result != null) _fetchZaposleni();
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 173, 160, 117),
                      Color.fromARGB(255, 192, 179, 139)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: (korisnik?.slika != null &&
                              korisnik!.slika!.isNotEmpty)
                          ? MemoryImage(base64Decode(korisnik.slika!))
                          : null,
                      child:
                          (korisnik?.slika == null || korisnik!.slika!.isEmpty)
                              ? Icon(Icons.person, size: 30)
                              : null,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '${korisnik?.ime ?? "Nepoznato"} ${korisnik?.prezime ?? ""}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('Zanimanje: ${e.zanimanje}'),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Obrisi zaposlenog'),
                              content: Text(
                                  'Da li ste sigurni da zelite obrisati zaposlenog?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // zatvori dialog
                                  },
                                  child: Text('Ugasi'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // pozovi delete iz providera
                                    await _zaposleniProvider
                                        .delete(e.zaposleniId!);
                                    Navigator.of(context).pop();
                                    // refresaj listu da se vidi promjena
                                    _refreshZaposleni();
                                  },
                                  child: Text('Obrisi'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
