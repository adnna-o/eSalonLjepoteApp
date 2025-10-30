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
import 'package:intl/intl.dart';
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
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _imeKlijentaController,
                      onChanged: (value) => _onSearchChanged(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,
                            color: Color.fromARGB(255, 173, 160, 117)),
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
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _nazivUslugeController,
                      onChanged: (value) => _onSearchChanged(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.design_services,
                            color: Color.fromARGB(255, 173, 160, 117)),
                        labelText: "Naziv usluge",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _searchData,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 173, 160, 117),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text("Pretraži",
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

 @override
Widget build(BuildContext context) {
  double maxWidth = 1000; // maksimalna širina za search i listu
  return MasterScreenWidget(
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/homepage.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center( // centriramo sadržaj horizontalno
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              _buildSearch(), // search bar
              const SizedBox(height: 8.0),
              Expanded(child: _buildDataListView()), // lista termina
              const SizedBox(height: 8.0),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 173, 160, 117),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Dodaj novi termin!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.all(12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(
              Color.fromARGB(255, 173, 160, 117)), // boja headera
          dataRowColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered))
                return Color.fromARGB(255, 173, 160, 117);
              return null; // default
            },
          ),
          headingTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255)),
          columns: const [
            DataColumn(label: Text('Usluga')),
            DataColumn(label: Text('Zaposleni')),
            DataColumn(label: Text('Klijent')),
            DataColumn(label: Text('Datum termina')),
            DataColumn(label: Text('Vrijeme termina')),
          ],
          rows: terminResult?.result.map((e) {
                var klijent = klijentiResult?.result
                    .firstWhere((k) => k.klijentId == e.klijentId);

                var korisnikKlijenta = klijent != null &&
                        klijent.korisnikId != null
                    ? korisnikResult?.result
                        .firstWhere((k) => k.korisnikId == klijent.korisnikId)
                    : null;

                String imeKlijenta = korisnikKlijenta?.ime ?? "Nepoznato";
                String prezimeKlijenta =
                    korisnikKlijenta?.prezime ?? "Nepoznato";

                var zaposleni = zaposleniResult?.result
                    .firstWhere((p) => p.zaposleniId == e.zaposleniId);
                var korisnik = zaposleni != null
                    ? korisnikResult?.result
                        .firstWhere((k) => k.korisnikId == zaposleni.korisnikId)
                    : null;
                var imeZaposlenog =
                    korisnik != null ? korisnik.ime : "Nepoznato";
                var prezimeZaposlenog =
                    korisnik != null ? korisnik.prezime : "Nepoznato";
                var nazivUsluge = uslugaResult?.result
                    .firstWhere((p) => p.uslugaId == e.uslugaId);

                return DataRow(
                  cells: [
                    DataCell(Text(nazivUsluge?.nazivUsluge ?? "")),
                    DataCell(Text("$imeZaposlenog $prezimeZaposlenog")),
                    DataCell(Text("$imeKlijenta $prezimeKlijenta")),
                    DataCell(
                        Text(DateFormat('dd.MM.yyyy').format(e.datumTermina!))),
                    DataCell(Text(e.vrijemeTermina.toString())),
                  ],
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
