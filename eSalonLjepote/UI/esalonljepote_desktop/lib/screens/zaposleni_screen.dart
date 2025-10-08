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
              child: Text("Add new Klijent!"),
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
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();

    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Ime i prezime zaposlenog ')),
            DataColumn(label: Text('Zanimanje')),
            DataColumn(label: Text('Obrisi')),
          ],
          rows: zaposleniResult?.result.map((Zaposleni e) {
                var zaposleni = zaposleniResult?.result
                    .firstWhere((p) => p.zaposleniId == e.zaposleniId);
                /* var zaposleni = zaposleniResult?.result
                    .firstWhere((p) => p.zaposleniId == e.zaposleniId);*/
                var korisnik = zaposleni != null
                    ? korisnikResult?.result
                        .firstWhere((k) => k.korisnikId == zaposleni.korisnikId)
                    : null;
                var imeZaposlenog =
                    korisnik != null ? korisnik.ime : "Nepoznato";
                var prezimeZaposlenog =
                    korisnik != null ? korisnik.prezime : "Nepoznato";
                /* var nazivUsluge = uslugaResult?.result
                    .firstWhere((p) => p.uslugaId == e.uslugaId);*/
                var korisnikSlika =
                    korisnik != null ? korisnik.slika : "Nepoznato";

                return DataRow(cells: [
                  DataCell(Text('$imeZaposlenog $prezimeZaposlenog')),
                  DataCell(Text(e.zanimanje.toString())),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Employee'),
                              content: Text(
                                  'Are you sure you want to delete this employee?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // zatvori dialog
                                  },
                                  child: Text('Cancel'),
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
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ]);
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
