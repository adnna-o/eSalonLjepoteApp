import 'dart:async';
import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:esalonljepote_desktop/models/search_result.dart';
import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/usluga.dart';
import 'package:esalonljepote_desktop/models/zaposleni.dart';
import 'package:esalonljepote_desktop/providers/klijenti_provider.dart';
import 'package:esalonljepote_desktop/providers/korisnik_provider.dart';
import 'package:esalonljepote_desktop/providers/termini_provider.dart';
import 'package:esalonljepote_desktop/providers/usluga_provider.dart';
import 'package:esalonljepote_desktop/providers/zaposleni_provider.dart';
import 'package:esalonljepote_desktop/screens/termin_details_screen.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class TerminScreen extends StatefulWidget {
  Termini? termini;
  TerminScreen({Key? key, this.termini}) : super(key: key);

  @override
  State<TerminScreen> createState() => _TerminScreen();
}

class _TerminScreen extends State<TerminScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KlijentiProvider _klijentiProvider;
  late TerminiProvider _terminProvider;
  late ZaposleniProvider _zaposleniProvider;
  late KorisnikProvider _korisnikProvider;
  late UslugaProvider _uslugaProvider;

  SearchResult<Termini>? terminResult;
  SearchResult<Klijenti>? klijentiResult;
  SearchResult<Zaposleni>? zaposleniResult;
  SearchResult<Korisnik>? korisnikResult;
  SearchResult<Usluga>? uslugaResult;

  TextEditingController _imeKlijentaController = TextEditingController();
  TextEditingController _prezimeKlijentaController = TextEditingController();
  TextEditingController _nazivUslugeController = TextEditingController();

  bool searchExecuted = false;
  Timer? _debounce;

//Inicijalizacija providera
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _terminProvider = context.read<TerminiProvider>();
    _klijentiProvider = context.read<KlijentiProvider>();
    _zaposleniProvider = context.read<ZaposleniProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _uslugaProvider = context.read<UslugaProvider>();

    _fetchTermini();
  }

//buduca funkcija
  Future<void> _fetchTermini() async {
    var terminData = await _terminProvider.get();
    var klijentiData = await _klijentiProvider.get();
    var zaposleniData = await _zaposleniProvider.get();
    var korisnikData = await _korisnikProvider.get();
    var uslugaData = await _uslugaProvider.get();

    setState(() {
      terminResult = terminData;
      klijentiResult = klijentiData;
      zaposleniResult = zaposleniData;
      korisnikResult = korisnikData;
      uslugaResult = uslugaData;
    });
    print(terminResult);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      var data = await _terminProvider.get(filter: {
        'imeKlijenta': _imeKlijentaController.text.trim(),
        'prezimeKlijenta': _prezimeKlijentaController.text.trim(),
        'nazivUsluge': _nazivUslugeController.text.trim(),
      });
      setState(() {
        terminResult = data;
      });
    });
  }

  Future<void> _searchData() async {
    var filter = {
      'imeKlijenta': _imeKlijentaController.text,
      'prezimeKlijenta': _prezimeKlijentaController.text,
      'nazivUsluge': _nazivUslugeController.text,
    };

    var data = await _terminProvider.get(filter: filter);

    setState(() {
      terminResult = data;
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
                      controller: _imeKlijentaController,
                      onChanged: (value) => _onSearchChanged(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.person_search,
                      color: const Color.fromARGB(255, 34, 78, 57)),
                  SizedBox(width: 8),
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
                      controller: _prezimeKlijentaController,
                      onChanged: (value) => _onSearchChanged(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.person_search,
                      color: const Color.fromARGB(255, 34, 78, 57)),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Naziv usluge",
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
                      controller: _nazivUslugeController,
                      onChanged: (value) => _onSearchChanged(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
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
                    builder: (context) => TerminDetailsScreen(
                      onDataChanged: _fetchTermini,
                    ),
                  ),
                );
                if (result != null) {
                  _fetchTermini();
                }
              },
              child: Text("Add new appointment!"),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshTermini() async {
    var terminData = await _terminProvider.get();

    setState(() {
      terminResult = terminData;
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
            DataColumn(label: Text('TerminId')),
            DataColumn(label: Text('UslugeId')),
            DataColumn(label: Text('ZaposleniId')),
            DataColumn(label: Text('KlijentId')),
            DataColumn(label: Text('Datum termina')),
            DataColumn(label: Text('Vrijeme termina')),
          ],
          rows: terminResult?.result.map((Termini e) {
                var klijentIme = klijentiResult?.result
                    .firstWhere((p) => p.klijentId == e.klijentId);
                var zaposleni = zaposleniResult?.result
                    .firstWhere((p) => p.zaposleniId == e.zaposleniId);
                var korisnik = zaposleni != null
                    ? korisnikResult?.result
                        .firstWhere((k) => k.korisnikId == zaposleni.korisnikId)
                    : null;
                var imeZaposlenog =
                    korisnik != null ? korisnik.ime : "Nepoznato";
                var nazivUsluge = uslugaResult?.result
                    .firstWhere((p) => p.uslugaId == e.uslugaId);

                return DataRow(cells: [
                  DataCell(Text(e.datumTermina.toString())),
                  DataCell(Text(nazivUsluge?.nazivUsluge ?? "")),
                  DataCell(Text(imeZaposlenog!)),
                  DataCell(Text(e.klijentId.toString())),
                  DataCell(Text(e.datumTermina.toString())),
                  DataCell(Text(e.vrijemeTermina.toString())),
                ]);
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
