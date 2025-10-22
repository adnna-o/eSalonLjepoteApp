import 'dart:async';
import 'dart:convert';
import 'package:esalonljepote_mobile/models/proizvod.dart';
import 'package:esalonljepote_mobile/models/search_result.dart';
import 'package:esalonljepote_mobile/providers/cart_provider.dart';
import 'package:esalonljepote_mobile/providers/proizvod_provider.dart';
import 'package:esalonljepote_mobile/screens/preporuceni_proizvodi_screen.dart';
import 'package:esalonljepote_mobile/utils/util.dart';
import 'package:esalonljepote_mobile/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ProizvodScreen extends StatefulWidget {
  Proizvod? proizvod;
  ProizvodScreen({Key? key, this.proizvod}) : super(key: key);

  @override
  State<ProizvodScreen> createState() => _ProizvodScreen();
}

class _ProizvodScreen extends State<ProizvodScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late ProizvodProvider _proizvodProvider;

  SearchResult<Proizvod>? proizvodResult;
  List<Proizvod>? _proizvodi;

  TextEditingController _nazivController = TextEditingController();

  bool searchExecuted = false;
  bool _showRecommendedProizvodi = false;
  Timer? _debounce;

//Inicijalizacija providera
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _proizvodProvider = context.read<ProizvodProvider>();

    _fetchProizvod();
    _fetchRecommendedProizvodi();
  }

//buduca funkcija
  Future<void> _fetchProizvod() async {
    var proizvodData = await _proizvodProvider.get();

    setState(() {
      proizvodResult = proizvodData;
    });
  }

  Future<void> _fetchRecommendedProizvodi() async {
    try {
      _proizvodi = await _proizvodProvider.fetchRecommendedProizvodi();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
    setState(() {});
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      var data = await _proizvodProvider.get(filter: {
        'nazivProizvoda': _nazivController.text.trim(),
      });
      setState(() {
        proizvodResult = data;
      });
    });
  }

  Future<void> _searchData() async {
    var filter = {
      'nazivProizvoda': _nazivController.text,
    };

    var data = await _proizvodProvider.get(filter: filter);

    setState(() {
      proizvodResult = data;
      searchExecuted = true;
    });
  }

  void _toggleRecommendedDoctors() {
    setState(() {
      _showRecommendedProizvodi = !_showRecommendedProizvodi;
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
                        labelText: "Naziv proizvod",
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
                      controller: _nazivController,
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
            /* ElevatedButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProizvodDetailsScreen(
                      onProizvodUpdated: _fetchProizvod,
                    ),
                  ),
                );
                if (result != null) {
                  _fetchProizvod();
                }
              },
              child: Text("Add new Proizvod!"),
            ),*/
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _toggleRecommendedDoctors,
              child: Text(_showRecommendedProizvodi
                  ? 'Hide recommended doctors'
                  : 'Show recommended doctors'),
            ),
            if (_showRecommendedProizvodi)
              Container(
                width: double.infinity,
                height: 300,
                child: PreporuceniProizvodiScreen(),
              ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _refreshProizvodi() async {
    var proizvodData = await _proizvodProvider.get();

    setState(() {
      proizvodResult = proizvodData;
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
            DataColumn(label: Text('Naziv proizvoda ')),
            DataColumn(label: Text('Slika')),
            DataColumn(label: Text('Cijena')),
            DataColumn(label: Text('Dodaj u korpu')),
          ],
          rows: proizvodResult?.result.map((Proizvod e) {
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
                  DataCell(Text(e.nazivProizvoda.toString())),
                  DataCell(
                    e.slika != null && e.slika!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.memory(
                              base64Decode(e.slika!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                            ),
                            child: const Center(child: Text('Nema slike')),
                          ),
                  ),
                  DataCell(Text(e.cijena.toString())),
                  DataCell(
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 174, 159, 136),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () async {
                        if (Authorization.userId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Niste prijavljeni!")),
                          );
                          return;
                        }

                        try {
                          await context
                              .read<CartProvider>()
                              .addToCart(Authorization.userId!, e.proizvodId!);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "${e.nazivProizvoda} je dodan u korpu!")),
                          );
                        } catch (ex) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text("Greška pri dodavanju u korpu: $ex")),
                          );
                        }
                      },
                      child: const Text("Dodaj u korpu"),
                    ),
                  )
                ]);
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
