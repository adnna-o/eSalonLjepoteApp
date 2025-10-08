import 'dart:async';
import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:esalonljepote_desktop/models/narudzba.dart';
import 'package:esalonljepote_desktop/models/placanje.dart';
import 'package:esalonljepote_desktop/models/proizvod.dart';
import 'package:esalonljepote_desktop/models/search_result.dart';
import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/usluga.dart';
import 'package:esalonljepote_desktop/models/zaposleni.dart';
import 'package:esalonljepote_desktop/providers/klijenti_provider.dart';
import 'package:esalonljepote_desktop/providers/korisnik_provider.dart';
import 'package:esalonljepote_desktop/providers/narudzba_provider.dart';
import 'package:esalonljepote_desktop/providers/placanje_provider.dart';
import 'package:esalonljepote_desktop/providers/proizvod_provider.dart';
import 'package:esalonljepote_desktop/providers/termini_provider.dart';
import 'package:esalonljepote_desktop/providers/usluga_provider.dart';
import 'package:esalonljepote_desktop/providers/zaposleni_provider.dart';
import 'package:esalonljepote_desktop/screens/narudzba_details_screen.dart';
import 'package:esalonljepote_desktop/screens/termin_details_screen.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class NarudzbaScreen extends StatefulWidget {
  Narudzba? narudzba;
  NarudzbaScreen({Key? key, this.narudzba}) : super(key: key);

  @override
  State<NarudzbaScreen> createState() => _NarudzbaScreen();
}

class _NarudzbaScreen extends State<NarudzbaScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KorisnikProvider _korisnikProvider;
  late NarudzbaProvider _narudzbaProvider;
  late ProizvodProvider _proizvodProvider;
  late PlacanjeProvider _placanjeProvider;

  SearchResult<Korisnik>? korisnikResult;
  SearchResult<Narudzba>? narudzbaResult;
  SearchResult<Proizvod>? proizvodResult;
  SearchResult<Placanje>? placanjeResult;

  TextEditingController _imeKlijentaController = TextEditingController();
  TextEditingController _prezimeKlijentaController = TextEditingController();
  TextEditingController _nazivUslugeController = TextEditingController();

  bool searchExecuted = false;
  Timer? _debounce;

//Inicijalizacija providera
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
    _narudzbaProvider = context.read<NarudzbaProvider>();
    _proizvodProvider = context.read<ProizvodProvider>();
    _placanjeProvider = context.read<PlacanjeProvider>();

    _fetchNarudzba();
  }

//buduca funkcija
  Future<void> _fetchNarudzba() async {
    var korisnikData = await _korisnikProvider.get();
    var proizvodData = await _proizvodProvider.get();
    var narudzbaData = await _narudzbaProvider.get();
    var placanjeData = await _placanjeProvider.get();

    setState(() {
      korisnikResult = korisnikData;
      proizvodResult = proizvodData;
      narudzbaResult = narudzbaData;
      placanjeResult = placanjeData;
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      var data = await _narudzbaProvider.get(filter: {
        'imeKlijenta': _imeKlijentaController.text.trim(),
        'prezimeKlijenta': _prezimeKlijentaController.text.trim(),
      });
      setState(() {
        narudzbaResult = data;
      });
    });
  }

  Future<void> _searchData() async {
    var filter = {
      'imeKlijenta': _imeKlijentaController.text,
      'prezimeKlijenta': _prezimeKlijentaController.text,
    };

    var data = await _narudzbaProvider.get(filter: filter);

    setState(() {
      narudzbaResult = data;
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
                    builder: (context) => NarudzbaDetailsScreen(
                      onDataChanged: _fetchNarudzba,
                    ),
                  ),
                );
                if (result != null) {
                  _fetchNarudzba();
                }
              },
              child: Text("Add new narudzba!"),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshNarudzba() async {
    var narudzbaData = await _narudzbaProvider.get();

    setState(() {
      narudzbaResult = narudzbaData;
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
            DataColumn(label: Text('KorisnikId')),
            DataColumn(label: Text('ProizvodId')),
            DataColumn(label: Text('PlacanjeId')),
            DataColumn(label: Text('Datum termina')),
            DataColumn(label: Text('Kolicina proizvoda')),
            DataColumn(label: Text('Iznos')),
          ],
          rows: narudzbaResult?.result.map((Narudzba e) {
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
                    .firstWhere((p) => p.uslugaId == e.uslugaId);*/

                var korisnikIme = korisnikResult?.result
                    .firstWhere((p) => p.korisnikId == e.korisnikId);
                var proizvodNaziv = proizvodResult?.result
                    .firstWhere((p) => p.proizvodId == e.proizvodId);
                var nacinPlacanjaNaziv = placanjeResult?.result
                    .firstWhere((p) => p.placanjeId == e.placanjeId);

                return DataRow(cells: [
                  DataCell(Text(korisnikIme!.ime ?? "")),
                  DataCell(Text(proizvodNaziv!.nazivProizvoda ?? "")),
                  DataCell(Text(nacinPlacanjaNaziv!.nacinPlacanja ?? "")),
                  DataCell(Text(e.datumNarudzbe.toString())),
                  DataCell(Text(e.kolicinaProizvoda.toString())),
                  DataCell(Text(e.iznosNarudzbe.toString())),
                ]);
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
