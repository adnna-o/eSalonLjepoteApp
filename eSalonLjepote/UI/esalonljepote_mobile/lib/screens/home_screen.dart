import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:esalonljepote_mobile/models/novosti.dart';
import 'package:esalonljepote_mobile/models/search_result.dart';
import 'package:esalonljepote_mobile/models/usluga.dart';
import 'package:esalonljepote_mobile/providers/novosti_provider.dart';
import 'package:esalonljepote_mobile/providers/usluga_provider.dart';
import 'package:esalonljepote_mobile/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final Usluga? usluga;
  final Novosti? novosti;

  const HomeScreen({Key? key, this.usluga, this.novosti}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late UslugaProvider _uslugaProvider;
  late NovostiProvider _novostiProvider;

  SearchResult<Usluga>? uslugaResult;
  SearchResult<Novosti>? novostiResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _uslugaProvider = context.read<UslugaProvider>();
    _novostiProvider = context.read<NovostiProvider>();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final fetchedUsluge = await _uslugaProvider.get();
    final fetchedNovosti = await _novostiProvider.get();
    setState(() {
      uslugaResult = fetchedUsluge;
      novostiResult = fetchedNovosti;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MasterScreenWidget(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Pozadinska slika
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/stuff.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Tamni overlay
              Container(color: Colors.black.withOpacity(0.3)),

              // Glavni sadržaj
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Dobrodošlica
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          "✨ Dobrodošli u eSalonLjepote ✨\nOtkrijte ljepotu u svakom detalju",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth < 500 ? 24 : 36,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 228, 196, 196),
                            shadows: const [
                              Shadow(
                                offset: Offset(1.5, 1.5),
                                blurRadius: 3.0,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // USLUGE
                      Text(
                        "Usluge koje nudimo",
                        style: TextStyle(
                          fontSize: screenWidth < 500 ? 18 : 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),

                      if (uslugaResult?.result != null &&
                          uslugaResult!.result.isNotEmpty)
                        CarouselSlider.builder(
                          itemCount: uslugaResult!.result.length,
                          itemBuilder: (context, index, realIndex) {
                            final usluga = uslugaResult!.result[index];
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: const Color.fromARGB(255, 176, 134, 134)
                                  .withOpacity(0.85),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      usluga.nazivUsluge ?? "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            screenWidth < 500 ? 14 : 16,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Cijena: ${usluga.cijena} KM",
                                      style: TextStyle(
                                        fontSize:
                                            screenWidth < 500 ? 12 : 14,
                                      ),
                                    ),
                                    Text(
                                      "Trajanje: ${usluga.trajanje} min",
                                      style: TextStyle(
                                        fontSize:
                                            screenWidth < 500 ? 12 : 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: screenWidth < 500 ? 180 : 200,
                            viewportFraction: screenWidth < 600 ? 0.8 : 0.33,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayInterval:
                                const Duration(seconds: 3),
                          ),
                        ),
                      const SizedBox(height: 24),

                      // NOVOSTI
                      Text(
                        "Novosti",
                        style: TextStyle(
                          fontSize: screenWidth < 500 ? 18 : 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),

                      if (novostiResult?.result != null &&
                          novostiResult!.result.isNotEmpty)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: screenWidth < 600
                                ? 1
                                : screenWidth < 900
                                    ? 2
                                    : 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1,
                          ),
                          itemCount: novostiResult!.result.length,
                          itemBuilder: (context, index) {
                            final novost = novostiResult!.result[index];
                            String datum = '';
                            if (novost.datumObjave != null) {
                              final dt = novost.datumObjave!;
                              datum =
                                  "${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}";
                            }

                            return Card(
                              color: Colors.black.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      novost.naziv ?? "",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      novost.opisNovisti ?? "",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white70),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Datum: $datum",
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Aktivna: ",
                                          style: TextStyle(
                                              color: Colors.white70),
                                        ),
                                        Checkbox(
                                          value: novost.aktivna == 1 ||
                                              novost.aktivna == true,
                                          onChanged: null,
                                          checkColor: const Color.fromARGB(
                                              255, 190, 144, 144),
                                          activeColor: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
