import 'package:esalonljepote_mobile/models/ocjene_proizvoda.dart';
import 'package:esalonljepote_mobile/models/proizvod.dart';
import 'package:esalonljepote_mobile/models/search_result.dart';
import 'package:esalonljepote_mobile/providers/ocjene_proizvoda_provider.dart';
import 'package:esalonljepote_mobile/providers/proizvod_provider.dart';
import 'package:esalonljepote_mobile/widget/master_screen.dart';
import 'package:flutter/material.dart';

class PreporuceniProizvodiScreen extends StatefulWidget {
  @override
  State<PreporuceniProizvodiScreen> createState() => _PreporuceniProizvodiScreen();
}
class _PreporuceniProizvodiScreen extends State<PreporuceniProizvodiScreen> {
  final ProizvodProvider proizvodProvider = ProizvodProvider();
  final OcjeneProizvodaProvider ocjeneProizvodaProvider = OcjeneProizvodaProvider();
  double? _selectedRating;
  List<Proizvod>? _proizvod;
  SearchResult<OcjeneProizvoda>? result;

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    try {
      _proizvod = await proizvodProvider.fetchRecommendedProizvodi();
      result = await ocjeneProizvodaProvider.get();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching data: $e')),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      title_widget: Text('Recommended proizvodi'),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton<double>(
                hint: Text('Choose a rating'),
                value: _selectedRating,
                items: _proizvod != null
                    ? groupProizvodByRating(_proizvod!).map((group) {
                        return DropdownMenuItem<double>(
                          value: group.rating,
                          child: Text(
                              'Rating: ${group.rating.toStringAsFixed(1)}'),
                        );
                      }).toList()
                    : [],
                onChanged: (value) {
                  setState(() {
                    _selectedRating = value;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: _selectedRating != null && _proizvod != null
                ? ListView.builder(
                    itemCount: groupProizvodByRating(_proizvod!).length,
                    itemBuilder: (context, index) {
                      final ratingGroup =
                          groupProizvodByRating(_proizvod!)[index];

                      if (ratingGroup.rating != _selectedRating) {
                        return SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Average proizvod rating: ${ratingGroup.rating.toStringAsFixed(1)}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            ...ratingGroup.proizvods.map((proizvod) => ListTile(
                                  title:
                                      Text(' ${proizvod.nazivProizvoda}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('proizvod: ${proizvod.proizvodId}'),
                                      _buildOcjeneForDoktor(proizvod.proizvodId),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      );
                    },
                  )
                : Center(child: Text('Select a rating to display the doctor')),
          ),
          if (_selectedRating != null &&
              _proizvod != null &&
              !groupProizvodByRating(_proizvod!)
                  .any((group) => group.rating == _selectedRating))
            Center(child: Text('Nema doktora s odabranom ocjenom')),
        ],
      ),
    );
  }

  Widget _buildOcjeneForDoktor(int? proizvodId) {
    final ocjeneZaProizvod =
        result?.result.where((ocjena) => ocjena.proizvodId == proizvodId).toList();

    if (ocjeneZaProizvod == null || ocjeneZaProizvod.isEmpty) {
      return Text('Nema ocjena za ovog doktora');
    }
    final brojOcjena = ocjeneZaProizvod.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Number of ratings: $brojOcjena'),
        ...ocjeneZaProizvod.map((ocjena) {
          return Text('Rating: ${ocjena.ocjena}, Reason: ${ocjena.opis}');
        }).toList(),
      ],
    );
  }

  List<RatingGroup> groupProizvodByRating(List<Proizvod> proizvods) {
    Map<double, List<Proizvod>> grouped = {};
    for (var proizvod in proizvods) {
      final rating = proizvod.averageRating ?? 0;
      if (!grouped.containsKey(rating)) {
        grouped[rating] = [];
      }
      grouped[rating]!.add(proizvod);
    }

    return grouped.entries
        .map((entry) => RatingGroup(rating: entry.key, proizvods: entry.value))
        .toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
  }
}

class RatingGroup {
  final double rating;
  final List<Proizvod> proizvods;

  RatingGroup({required this.rating, required this.proizvods});
}