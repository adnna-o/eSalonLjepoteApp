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
import 'package:provider/provider.dart';

class ProizvodScreen extends StatefulWidget {
  Proizvod? proizvod;
  ProizvodScreen({Key? key, this.proizvod}) : super(key: key);

  @override
  State<ProizvodScreen> createState() => _ProizvodScreen();
}

class _ProizvodScreen extends State<ProizvodScreen> {
  late ProizvodProvider _proizvodProvider;
  SearchResult<Proizvod>? proizvodResult;
  List<Proizvod>? _proizvodi;
  TextEditingController _nazivController = TextEditingController();
  Timer? _debounce;
  bool _showRecommendedProizvodi = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _proizvodProvider = context.read<ProizvodProvider>();
    _fetchProizvod();
    _fetchRecommendedProizvodi();
  }

  Future<void> _fetchProizvod() async {
    var data = await _proizvodProvider.get();
    setState(() {
      proizvodResult = data;
    });
  }

  Future<void> _fetchRecommendedProizvodi() async {
    try {
      _proizvodi = await _proizvodProvider.fetchRecommendedProizvodi();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error fetching data: $e')));
    }
    setState(() {});
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      var data = await _proizvodProvider.get(
          filter: {'nazivProizvoda': _nazivController.text.trim()});
      setState(() {
        proizvodResult = data;
      });
    });
  }

  void _toggleRecommendedProizvodi() {
    setState(() {
      _showRecommendedProizvodi = !_showRecommendedProizvodi;
    });
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: _nazivController,
        onChanged: (_) => _onSearchChanged(),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Color.fromARGB(255, 134, 98, 100)),
          hintText: "Pretraži proizvode",
          filled: true,
          fillColor: Color.fromARGB(255, 205, 203, 203),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildProizvodCard(Proizvod e) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      shadowColor: Color.fromARGB(255, 149, 132, 136),
      color: Colors.white.withOpacity(0.85),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: e.slika != null && e.slika!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.memory(
                      base64Decode(e.slika!),
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 118, 91, 91),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Center(
                        child: Text(
                      'Nema slike',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.nazivProizvoda!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 100, 57, 59),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "${e.cijena} KM",
              style: TextStyle(color: Color.fromARGB(255, 100, 57, 59)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 192, 148, 148),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () async {
                // Authorization ostaje netaknut
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
                    SnackBar(content: Text("${e.nazivProizvoda} je dodan u korpu!")),
                  );
                } catch (ex) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Greška pri dodavanju u korpu: $ex")),
                  );
                }
              },
              child: Text("Dodaj u korpu",
                  style: TextStyle(color: Color.fromARGB(255, 100, 57, 59))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;
    if (screenWidth < 600) {
      crossAxisCount = 1; // mobilni
    } else if (screenWidth < 900) {
      crossAxisCount = 2; // tablet
    } else {
      crossAxisCount = 3; // desktop
    }

    return MasterScreenWidget(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Background.jpg'), // stavi svoju sliku
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: proizvodResult == null
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      padding: EdgeInsets.all(12),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: proizvodResult!.result.length,
                      itemBuilder: (context, index) =>
                          _buildProizvodCard(proizvodResult!.result[index]),
                    ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 166, 120, 129),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: _toggleRecommendedProizvodi,
              child: Text(
                _showRecommendedProizvodi ? "Sakrij preporučene" : "Prikaži preporučene",
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (_showRecommendedProizvodi)
              SizedBox(
                height: 300,
                child: PreporuceniProizvodiScreen(),
              ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
