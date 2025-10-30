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
  TextEditingController _sadrzajNarudzbeController = TextEditingController();
  TextEditingController _iznosController = TextEditingController();
  TextEditingController _kolicinaController = TextEditingController();

  DateTime? _datumOd;
  DateTime? _datumDo;

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
        'sadrzajNarudzbe': _sadrzajNarudzbeController.text.trim(),
        'kolicinaProizvoda': _kolicinaController.text.trim(),
        'iznosNarudzbe': _iznosController.text.trim(),
      });
      setState(() {
        narudzbaResult = data;
      });
    });
  }

  Future<void> _searchData() async {
    var filter = {
      'imeKlijenta': _imeKlijentaController.text.trim(),
      'prezimeKlijenta': _prezimeKlijentaController.text.trim(),
      'sadrzajNarudzbe': _sadrzajNarudzbeController.text.trim(),
      'kolicinaProizvoda': _kolicinaController.text.isNotEmpty
          ? int.parse(_kolicinaController.text)
          : null,
      'iznosNarudzbe': _iznosController.text.isNotEmpty
          ? double.parse(_iznosController.text)
          : null,
      'datumOd': _datumOd?.toIso8601String(),
      'datumDo': _datumDo?.toIso8601String(),
    };

    var data = await _narudzbaProvider.get(filter: filter);

    setState(() {
      narudzbaResult = data;
      searchExecuted = true;
    });
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Prvi red: ime i prezime klijenta
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _imeKlijentaController,
                      onChanged: (value) => _onSearchChanged(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,
                            color: Color.fromARGB(255, 34, 78, 57)),
                        labelText: "Ime klijenta",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _prezimeKlijentaController,
                      onChanged: (value) => _onSearchChanged(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline,
                            color: Color.fromARGB(255, 173, 160, 117)),
                        labelText: "Prezime klijenta",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              // Drugi red: količina, iznos i sadržaj
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _kolicinaController,
                      decoration:
                          InputDecoration(labelText: "Količina proizvoda"),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _iznosController,
                      decoration: InputDecoration(labelText: "Iznos narudžbe"),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _sadrzajNarudzbeController,
                      decoration:
                          InputDecoration(labelText: "Sadržaj narudžbe"),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12),

              // Treći red: datum od, datum do i dugme pretrage
              // Treći red: datum od, datum do i dugme pretrage
              Row(
                children: [
                  Row(
                    children: [
                      Text(_datumOd == null
                          ? "Datum od"
                          : _datumOd.toString().split(" ")[0]),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          DateTime? selected = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (selected != null) {
                            setState(() {
                              _datumOd = selected;
                            });
                          }
                        },
                      ),
                      // Dugme za poništavanje
                      if (_datumOd != null)
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _datumOd = null; // poništava datum
                            });
                          },
                        ),
                    ],
                  ),
                  SizedBox(width: 12),
                  Row(
                    children: [
                      Text(_datumDo == null
                          ? "Datum do"
                          : _datumDo.toString().split(" ")[0]),
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () async {
                          DateTime? selected = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (selected != null) {
                            setState(() {
                              _datumDo = selected;
                            });
                          }
                        },
                      ),
                      // Dugme za poništavanje
                      if (_datumDo != null)
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _datumDo = null; // poništava datum
                            });
                          },
                        ),
                    ],
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: _searchData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 173, 160, 117),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child:
                        Text("Pretraži", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataListView() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor:
                MaterialStateProperty.all(Color.fromARGB(255, 173, 160, 117)),
            headingTextStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            columns: const [
              DataColumn(label: Text('Korisnik')),
              DataColumn(label: Text('Proizvod')),
              DataColumn(label: Text('Plaćanje')),
              DataColumn(label: Text('Datum narudžbe')),
              DataColumn(label: Text('Količina')),
              DataColumn(label: Text('Iznos')),
            ],
            rows: narudzbaResult?.result.map((Narudzba e) {
                  var korisnikIme = korisnikResult?.result
                      .firstWhere((p) => p.korisnikId == e.korisnikId);
                  var proizvodNaziv = proizvodResult?.result
                      .firstWhere((p) => p.proizvodId == e.proizvodId);
                  var nacinPlacanjaNaziv = placanjeResult?.result
                      .firstWhere((p) => p.placanjeId == e.placanjeId);

                  return DataRow(cells: [
                    DataCell(
                        Text("${korisnikIme?.ime} ${korisnikIme!.prezime}")),
                    DataCell(Text(proizvodNaziv?.nazivProizvoda ?? "")),
                    DataCell(Text(nacinPlacanjaNaziv?.nacinPlacanja ?? "")),
                    DataCell(Text(e.datumNarudzbe.toString())),
                    DataCell(Text(e.kolicinaProizvoda.toString())),
                    DataCell(Text(e.iznosNarudzbe.toString())),
                  ]);
                }).toList() ??
                [],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = 1000;
    return MasterScreenWidget(
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/homepage.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            // centriramo sadržaj horizontalno
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                children: [
                  _buildSearch(),
                  const SizedBox(height: 8.0),
                  Expanded(child: _buildDataListView()),
                  const SizedBox(height: 8.0),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 173, 160, 117),
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Dodaj novu narudžbu!",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _refreshNarudzba() async {
    var narudzbaData = await _narudzbaProvider.get();

    setState(() {
      narudzbaResult = narudzbaData;
    });
  }
}
