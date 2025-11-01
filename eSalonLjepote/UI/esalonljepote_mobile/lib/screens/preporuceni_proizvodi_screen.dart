import 'dart:convert';
import 'package:esalonljepote_mobile/models/ocjene_proizvoda.dart';
import 'package:esalonljepote_mobile/models/proizvod.dart';
import 'package:esalonljepote_mobile/providers/ocjene_proizvoda_provider.dart';
import 'package:esalonljepote_mobile/providers/proizvod_provider.dart';
import 'package:flutter/material.dart';

class PreporuceniProizvodiScreen extends StatefulWidget {
  @override
  State<PreporuceniProizvodiScreen> createState() =>
      _PreporuceniProizvodiScreen();
}

class _PreporuceniProizvodiScreen extends State<PreporuceniProizvodiScreen> {
  final ProizvodProvider proizvodProvider = ProizvodProvider();
  final OcjeneProizvodaProvider ocjeneProizvodaProvider =
      OcjeneProizvodaProvider();

  double? _selectedRating;
  List<Proizvod>? _proizvodi;
  List<OcjeneProizvoda>? _ocjeneResult;

  @override
  void initState() {
    super.initState();
    _fetchProizvodi();
  }

  Future<void> _fetchProizvodi() async {
    try {
      _proizvodi = await proizvodProvider.fetchRecommendedProizvodi();
      final result = await ocjeneProizvodaProvider.get();
      _ocjeneResult = result.result;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching data: $e')),
        );
      }
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 600 ? 1 : screenWidth < 900 ? 2 : 3;

    final ratingGroups =
        _proizvodi != null ? groupProizvodByRating(_proizvodi!) : [];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 241, 242),
      appBar: AppBar(
        title: const Text(
          "Preporučeni proizvodi",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 134, 98, 100),
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: _proizvodi == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  if (_proizvodi!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<double>(
                              hint: const Text('Odaberi ocjenu'),
                              value: _selectedRating,
                              items: ratingGroups.map((group) {
                                return DropdownMenuItem<double>(
                                  value: group.rating,
                                  child: Text(
                                    'Ocjena: ${group.rating.toStringAsFixed(1)}',
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedRating = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: screenWidth < 600 ? 0.8 : 0.7,
                      ),
                      itemCount: _proizvodi!.length,
                      itemBuilder: (context, index) {
                        final proizvod = _proizvodi![index];
                        if (_selectedRating != null &&
                            proizvod.averageRating != _selectedRating) {
                          return const SizedBox.shrink();
                        }
                        return _buildProizvodCard(proizvod);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildProizvodCard(Proizvod proizvod) {
    final ocjeneZaProizvod = _ocjeneResult
        ?.where((o) => o.proizvodId == proizvod.proizvodId)
        .toList();

    String? base64String;
    if (proizvod.slika != null && proizvod.slika!.isNotEmpty) {
      base64String = proizvod.slika!.contains(',')
          ? proizvod.slika!.split(',').last
          : proizvod.slika;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 5,
          shadowColor: const Color.fromARGB(255, 149, 132, 136),
          color: Colors.white.withOpacity(0.9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 6,
                child: base64String != null
                    ? ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.memory(
                          base64Decode(base64String),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 118, 91, 91),
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16)),
                        ),
                        child: const Center(
                          child: Text(
                            'Nema slike',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        proizvod.nazivProizvoda ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 100, 57, 59),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${proizvod.cijena ?? 0} KM",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 100, 57, 59),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (ocjeneZaProizvod != null &&
                          ocjeneZaProizvod.isNotEmpty)
                        Text(
                          "Ocjena: ${proizvod.averageRating?.toStringAsFixed(1) ?? '0'} (${ocjeneZaProizvod.length} ocjena)",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 134, 98, 100),
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<RatingGroup> groupProizvodByRating(List<Proizvod> proizvodi) {
    Map<double, List<Proizvod>> grouped = {};
    for (var proizvod in proizvodi) {
      final rating = proizvod.averageRating ?? 0;
      grouped.putIfAbsent(rating, () => []).add(proizvod);
    }

    return grouped.entries
        .map((entry) => RatingGroup(rating: entry.key, proizvodi: entry.value))
        .toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
  }
}

class RatingGroup {
  final double rating;
  final List<Proizvod> proizvodi;
  RatingGroup({required this.rating, required this.proizvodi});
}
