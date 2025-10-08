import 'dart:async';
import 'dart:convert';
import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:esalonljepote_desktop/models/novosti.dart';
import 'package:esalonljepote_desktop/models/proizvod.dart';
import 'package:esalonljepote_desktop/models/search_result.dart';
import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/usluga.dart';
import 'package:esalonljepote_desktop/models/zaposleni.dart';
import 'package:esalonljepote_desktop/providers/klijenti_provider.dart';
import 'package:esalonljepote_desktop/providers/korisnik_provider.dart';
import 'package:esalonljepote_desktop/providers/novosti_provider.dart';
import 'package:esalonljepote_desktop/providers/proizvod_provider.dart';
import 'package:esalonljepote_desktop/providers/termini_provider.dart';
import 'package:esalonljepote_desktop/providers/usluga_provider.dart';
import 'package:esalonljepote_desktop/providers/zaposleni_provider.dart';
import 'package:esalonljepote_desktop/screens/novosti_details_screen.dart';
import 'package:esalonljepote_desktop/screens/proizvod_datails_screen.dart';
import 'package:esalonljepote_desktop/screens/termin_details_screen.dart';
import 'package:esalonljepote_desktop/screens/usluga_details_screen.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class UslugaNovostiScreen extends StatefulWidget {
  Usluga? usluga;
  Novosti? novosti;
  UslugaNovostiScreen({Key? key, this.usluga, this.novosti}) : super(key: key);

  @override
  State<UslugaNovostiScreen> createState() => _UslugaNovostiScreen();
}

class _UslugaNovostiScreen extends State<UslugaNovostiScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late UslugaProvider _uslugaProvider;
  late NovostiProvider _novostiProvider;

  SearchResult<Usluga>? uslugaResult;
  SearchResult<Novosti>? novostiResult;

  bool searchExecuted = false;
  Timer? _debounce;

//Inicijalizacija providera
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _uslugaProvider = context.read<UslugaProvider>();
    _novostiProvider = context.read<NovostiProvider>();

    _fetchNovosti();
    _fetchUsluga();
  }

//buduca funkcija
  Future<void> _fetchNovosti() async {
    var novostiData = await _novostiProvider.get();

    setState(() {
      novostiResult = novostiData;
    });
  }

  Future<void> _fetchUsluga() async {
    var uslugaData = await _uslugaProvider.get();

    setState(() {
      uslugaResult = uslugaData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Container(
        child: Column(
          children: [
            Expanded(child: _buildUslugaListView()),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UslugaDetailsScreen(
                      onUslugaUpdate: _fetchUsluga,
                    ),
                  ),
                );
                if (result != null) {
                  _fetchUsluga();
                }
              },
              child: Text("Add new Usluga!"),
            ),
           Expanded(child: _buildNovostiListView()),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NovostiDetailsScreen(
                      onDataChanged: _fetchNovosti,
                    ),
                  ),
                );
                if (result != null) {
                  _fetchNovosti();
                }
              },
              child: Text("Add new Novosti!"),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshUsluga() async {
    var uslugaData = await _uslugaProvider.get();

    setState(() {
      uslugaResult = uslugaData;
    });
  }

  void _refreshNovosti() async {
    var novostiData = await _novostiProvider.get();

    setState(() {
      novostiResult = novostiData;
    });
  }

  Widget _buildUslugaListView() {
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();

    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Naziv usluge ')),
            DataColumn(label: Text('Cijena')),
            DataColumn(label: Text('Trajanje')),
          ],
          rows: uslugaResult?.result.map((Usluga e) {
                /* var klijentIme = klijentiResult?.result
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
*/
                return DataRow(cells: [
                  DataCell(Text(e.nazivUsluge.toString())),
                  DataCell(Text(e.cijena.toString())),
                  DataCell(Text(e.trajanje.toString())),
                ]);
              }).toList() ??
              [],
        ),
      ),
    );
  }

  Widget _buildNovostiListView() {
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();

    return Card(
      elevation: 5,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Naziv novosti ')),
            DataColumn(label: Text('Opis novosti')),
            DataColumn(label: Text('Datum objava')),
            DataColumn(label: Text('Aktivna objava: da/ne')),
          ],
          rows: novostiResult?.result.map((Novosti e) {
                /* var klijentIme = klijentiResult?.result
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
*/
                return DataRow(cells: [
                  DataCell(Text(e.naziv.toString())),
                  DataCell(Text(e.opisNovisti.toString())),
                  DataCell(Text(e.datumObjave.toString())),
                 DataCell(Text(e.aktivna == 1 || e.aktivna == true ? 'Da' : 'Ne')),
                ]);
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
