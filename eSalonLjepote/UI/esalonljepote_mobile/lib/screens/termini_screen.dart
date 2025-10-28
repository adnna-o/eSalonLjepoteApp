import 'dart:async';
import 'package:esalonljepote_mobile/models/klijenti.dart';
import 'package:esalonljepote_mobile/models/korisnik.dart';
import 'package:esalonljepote_mobile/models/search_result.dart';
import 'package:esalonljepote_mobile/models/termini.dart';
import 'package:esalonljepote_mobile/models/usluga.dart';
import 'package:esalonljepote_mobile/models/zaposleni.dart';
import 'package:esalonljepote_mobile/providers/klijenti_provider.dart';
import 'package:esalonljepote_mobile/providers/korisnik_provider.dart';
import 'package:esalonljepote_mobile/providers/termini_provider.dart';
import 'package:esalonljepote_mobile/providers/usluga_provider.dart';
import 'package:esalonljepote_mobile/providers/zaposleni_provider.dart';
import 'package:esalonljepote_mobile/widget/master_screen.dart';
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
  late TerminiProvider _terminProvider;
  late ZaposleniProvider _zaposleniProvider;
  late KorisnikProvider _korisnikProvider;
  late UslugaProvider _uslugaProvider;
  late KlijentiProvider _klijentiProvider;

  SearchResult<Termini>? terminResult;
  SearchResult<Zaposleni>? zaposleniResult;
  SearchResult<Korisnik>? korisnikResult;
  SearchResult<Usluga>? uslugaResult;
  SearchResult<Klijenti>? klijentiResult;

  TextEditingController _imeKlijentaController = TextEditingController();
  TextEditingController _prezimeKlijentaController = TextEditingController();
  TextEditingController _nazivUslugeController = TextEditingController();

  bool searchExecuted = false;
  Timer? _debounce;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _terminProvider = context.read<TerminiProvider>();
    _zaposleniProvider = context.read<ZaposleniProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _uslugaProvider = context.read<UslugaProvider>();
    _klijentiProvider = context.read<KlijentiProvider>();

    _fetchTermini();
    _fetchZaposleni();
    _fetchUsluga();
    _fetchKlijenti();
  }

  Future<void> _fetchTermini() async {
    var terminiData = await _terminProvider.get();

    setState(() {
      terminResult = terminiData;
    });
  }

  Future<void> _fetchZaposleni() async {
    var zaposleniData = await _zaposleniProvider.get();

    setState(() {
      zaposleniResult = zaposleniData;
    });
  }

  Future<void> _fetchUsluga() async {
    var uslugaData = await _uslugaProvider.get();

    setState(() {
      uslugaResult = uslugaData;
    });
  }

  Future<void> _fetchKlijenti() async {
    var klijentData = await _klijentiProvider.get();

    setState(() {
      klijentiResult = klijentData;
    });
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
            /*ElevatedButton(
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
            ),*/
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
              DataColumn(label: Text('Usluga')),
              DataColumn(label: Text('Zaposleni')),
              DataColumn(label: Text('Klijenti')),
              DataColumn(label: Text('Datum')),
              DataColumn(label: Text('Vrijeme')),
            ],
            rows: terminResult?.result.map((Termini e) {
                  var klijent = klijentiResult?.result.firstWhere(
                      (k) => k.klijentId == e.klijentId,
                      orElse: () => Klijenti(klijentId: 0, korisnikId: 0));

                  // 2️⃣ Dohvati korisnika preko klijent.korisnikId
                  var korisnik = korisnikResult?.result.firstWhere(
                      (k) => k.korisnikId == klijent?.korisnikId,
                      orElse: () => Korisnik(
                          korisnikId: 0, ime: "Nepoznato", prezime: ""));

                  var imeKlijenta =
                      "${korisnik?.ime ?? "Nepoznato"} ${korisnik?.prezime ?? ""}";

                  // 3️⃣ Dohvati uslugu
                  var usluga = uslugaResult?.result.firstWhere(
                      (u) => u.uslugaId == e.uslugaId,
                      orElse: () =>
                          Usluga(uslugaId: 0, nazivUsluge: "Nepoznata"));
                  var nazivUsluge = usluga?.nazivUsluge ?? "Nepoznata";

                  // 4️⃣ Dohvati zaposlenog i njegovo ime
                  var zaposleni = zaposleniResult?.result.firstWhere(
                      (z) => z.zaposleniId == e.zaposleniId,
                      orElse: () => Zaposleni(zaposleniId: 0, korisnikId: 0));
                  var zaposleniKorisnik = korisnikResult?.result.firstWhere(
                      (k) => k.korisnikId == zaposleni?.korisnikId,
                      orElse: () => Korisnik(
                          korisnikId: 0, ime: "Nepoznato", prezime: ""));
                  var imeZaposlenog =
                      "${zaposleniKorisnik?.ime ?? "Nepoznato"} ${zaposleniKorisnik?.prezime ?? ""}";

                  return DataRow(cells: [
                    DataCell(Text(e.terminId.toString())),
                    DataCell(Text(nazivUsluge)),
                    DataCell(Text(imeZaposlenog)),
                    DataCell(Text(imeKlijenta)),
                    DataCell(Text(e.datumTermina.toString())),
                    DataCell(Text(e.vrijemeTermina.toString())),
                  ]);
                }).toList() ??
                [],
          )),
    );
  }
}
