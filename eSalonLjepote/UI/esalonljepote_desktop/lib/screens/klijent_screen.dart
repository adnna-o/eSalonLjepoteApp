import 'dart:async';
import 'dart:convert';
import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:esalonljepote_desktop/models/narudzba.dart';
import 'package:esalonljepote_desktop/models/proizvod.dart';
import 'package:esalonljepote_desktop/models/search_result.dart';
import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/models/usluga.dart';
import 'package:esalonljepote_desktop/providers/klijenti_provider.dart';
import 'package:esalonljepote_desktop/providers/korisnik_provider.dart';
import 'package:esalonljepote_desktop/providers/narudzba_provider.dart';
import 'package:esalonljepote_desktop/providers/proizvod_provider.dart';
import 'package:esalonljepote_desktop/providers/termini_provider.dart';
import 'package:esalonljepote_desktop/providers/usluga_provider.dart';
import 'package:esalonljepote_desktop/screens/klijent_details_screen.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class KlijentScreen extends StatefulWidget {
  Klijenti? klijenti;
  KlijentScreen({Key? key, this.klijenti}) : super(key: key);

  @override
  State<KlijentScreen> createState() => _KlijentScreen();
}
class _KlijentScreen extends State<KlijentScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KlijentiProvider _klijentiProvider;
  late KorisnikProvider _korisnikProvider;
  late UslugaProvider _uslugaProvider;
  late TerminiProvider _terminiProvider;
  late NarudzbaProvider _narudzbaProvider;
  late ProizvodProvider _proizvodProvider;

  SearchResult<Klijenti>? klijentResult;
  SearchResult<Korisnik>? korisnikResult;
  SearchResult<Usluga>? uslugaResult;
  SearchResult<Termini>? terminResult;
  SearchResult<Narudzba>? narudzbaResult;
  SearchResult<Proizvod>? proizvodResult;

  TextEditingController _imeKlijentaController = TextEditingController();
  TextEditingController _prezimeKlijentaController = TextEditingController();
  TextEditingController _uslugaKlijentaController = TextEditingController();

  bool searchExecuted = false;
  Timer? _debounce;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _klijentiProvider = context.read<KlijentiProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _uslugaProvider = context.read<UslugaProvider>();
    _terminiProvider = context.read<TerminiProvider>();
    _narudzbaProvider = context.read<NarudzbaProvider>();
    _proizvodProvider = context.read<ProizvodProvider>();

    _fetchKlijenti();
    _fecthKorisnici();
    _fetchUsluga();
    _fetchTermini();
    _fetchNarudzba();
    _fetchProizvod();
  }

  Future<void> _fetchKlijenti() async {
    var klijentData = await _klijentiProvider.get();

    setState(() {
      klijentResult = klijentData;
    });
  }

  Future<void> _fecthKorisnici() async {
    var korisnikData = await _korisnikProvider.get();

    setState(() {
      korisnikResult = korisnikData;
    });
  }

  Future<void> _fetchUsluga() async {
    var uslugaData = await _uslugaProvider.get();

    setState(() {
      uslugaResult = uslugaData;
    });
  }

  Future<void> _fetchTermini() async {
    var terminData = await _terminiProvider.get();

    setState(() {
      terminResult = terminData;
    });
  }

  Future<void> _fetchNarudzba() async {
    var narudzbaData = await _narudzbaProvider.get();

    setState(() {
      narudzbaResult = narudzbaData;
    });
  }

  Future<void> _fetchProizvod() async {
    var proizvodData = await _proizvodProvider.get();

    setState(() {
      proizvodResult = proizvodData;
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      var data = await _klijentiProvider.get(filter: {
        'imeKlijenta': _imeKlijentaController.text.trim(),
        'prezimeKlijenta': _prezimeKlijentaController.text.trim(),
        'uslugaKlijenta': _uslugaKlijentaController.text.trim(),
      });
      setState(() {
        klijentResult = data;
      });
    });
  }

  Future<void> _searchData() async {
    var filter = {
      'imeKlijenta': _imeKlijentaController.text,
      'prezimeKlijenta': _prezimeKlijentaController.text,
      'uslugaKlijenta': _uslugaKlijentaController.text,
    };

    var data = await _klijentiProvider.get(filter: filter);

    setState(() {
      klijentResult = data;
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
                      controller: _uslugaKlijentaController,
                      onChanged: (value) => _onSearchChanged(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _searchData,
                child: Text("Pretrazi"),
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
            Expanded(child: _buildKlijentiCards()),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => KlijentiDetailsScreen(
                      onDataChanged: _fetchKlijenti,
                    ),
                  ),
                );
                if (result != null) {
                  _fetchKlijenti();
                }
              },
              child: Text("Dodaj novog klijenta!"),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshKlijenti() async {
    var klijentData = await _klijentiProvider.get();

    setState(() {
      klijentResult = klijentData;
    });
  }

  Widget _buildKlijentiCards() {
    if (klijentResult == null || klijentResult!.result.isEmpty) {
      return Center(
        child: Text("Nema klijenata za prikaz"),
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
      itemCount: klijentResult!.result.length,
      itemBuilder: (context, index) {
        Klijenti e = klijentResult!.result[index];
        var korisnik = korisnikResult?.result.firstWhere(
          (k) => k.korisnikId == e.korisnikId,
          orElse: () => Korisnik(ime: "Nepoznato", prezime: "", slika: ""),
        );

        var terminiZaKlijenta = terminResult?.result
            .where((t) => t.klijentId == e.klijentId)
            .toList();

        String nazivUsluge = "Nepoznata usluga";
        if (terminiZaKlijenta != null && terminiZaKlijenta.isNotEmpty) {
          var uslugaId = terminiZaKlijenta.first.uslugaId;
          var usluga = uslugaResult?.result.firstWhere(
              (u) => u.uslugaId == uslugaId,
              orElse: () => Usluga(nazivUsluge: "Nepoznata"));
          nazivUsluge = usluga?.nazivUsluge ?? "Nepoznata usluga";
        }

        var narudzbeZaKlijenta = narudzbaResult?.result
            .where((n) => n.korisnikId == e.korisnikId)
            .toList();

        String nazivProizvoda = "Nema narudžbi";
        if (narudzbeZaKlijenta != null && narudzbeZaKlijenta.isNotEmpty) {
          var proizvodId = narudzbeZaKlijenta.first.proizvodId;
          var proizvod = proizvodResult?.result.firstWhere(
            (p) => p.proizvodId == proizvodId,
            orElse: () => Proizvod(nazivProizvoda: "Nepoznat"),
          );
          nazivProizvoda = proizvod?.nazivProizvoda ?? "Nepoznat proizvod";
        }

        return Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => KlijentiDetailsScreen(
                    onDataChanged: _fetchKlijenti,
                    klijenti: e,
                  ),
                ),
              );
              if (result != null) _fetchKlijenti();
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 173, 160, 117), Color.fromARGB(255, 192, 179, 139)],
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
                    backgroundImage:
                        (korisnik?.slika != null && korisnik!.slika!.isNotEmpty)
                            ? MemoryImage(base64Decode(korisnik.slika!))
                            : null,
                    child: (korisnik?.slika == null || korisnik!.slika!.isEmpty)
                        ? Icon(Icons.person, size: 30)
                        : null,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${korisnik?.ime ?? "Nepoznato"} ${korisnik?.prezime ?? ""}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('Usluga: $nazivUsluge'),
                  Text('Narudžba: $nazivProizvoda'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
