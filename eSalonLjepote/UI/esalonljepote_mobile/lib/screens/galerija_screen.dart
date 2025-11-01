import 'dart:async';
import 'dart:convert';
import 'package:esalonljepote_mobile/models/galerija.dart';
import 'package:esalonljepote_mobile/models/korisnik.dart';
import 'package:esalonljepote_mobile/models/search_result.dart';
import 'package:esalonljepote_mobile/models/zaposleni.dart';
import 'package:esalonljepote_mobile/providers/galerija_provider.dart';
import 'package:esalonljepote_mobile/providers/korisnik_provider.dart';
import 'package:esalonljepote_mobile/providers/zaposleni_provider.dart';
import 'package:esalonljepote_mobile/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class GalerijaScreen extends StatefulWidget {
  Galerija? galerija;
  GalerijaScreen({Key? key, this.galerija}) : super(key: key);

  @override
  State<GalerijaScreen> createState() => _GalerijaScreen();
}

class _GalerijaScreen extends State<GalerijaScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late ZaposleniProvider _zaposleniProvider;
  late KorisnikProvider _korisnikProvider;
  late GalerijaProvider _galerijaProvider;

  SearchResult<Zaposleni>? zaposleniResult;
  SearchResult<Korisnik>? korisnikResult;
  SearchResult<Galerija>? galerijaResult;

  bool searchExecuted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _galerijaProvider = context.read<GalerijaProvider>();
    _zaposleniProvider = context.read<ZaposleniProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();

    _fetchGalerija();
  }

  Future<void> _fetchGalerija() async {
    var galerijaData = await _galerijaProvider.get();
    var zaposleniData = await _zaposleniProvider.get();
    var korisnikData = await _korisnikProvider.get();

    setState(() {
      galerijaResult = galerijaData;
      zaposleniResult = zaposleniData;
      korisnikResult = korisnikData;
    });
  }

  void _refreshGalerija() async {
    var galerijaData = await _galerijaProvider.get();

    setState(() {
      galerijaResult = galerijaData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Stack(
        children: [
          // POZADINSKA SLIKA SA OPACITY
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/stuff.png', // zamijeni svojom slikom
                fit: BoxFit.cover,
              ),
            ),
          ),
          // GRID VIEW SLIKA
          Column(
            children: [
              Expanded(child: _buildDataListView()),
              const SizedBox(height: 8.0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    if (galerijaResult == null || galerijaResult!.result.isEmpty) {
      return const Center(child: Text("Nema slika u galeriji."));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: galerijaResult!.result.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250, // maksimalna širina jednog itema
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 4 / 5,
        ),
        itemBuilder: (context, index) {
          final galerija = galerijaResult!.result[index];

          return Card(
            elevation: 6,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: galerija.slika != null && galerija.slika!.isNotEmpty
                ? Image.memory(
                    base64Decode(galerija.slika!),
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey[300],
                    child: const Center(child: Text('Nema slike')),
                  ),
          );
        },
      ),
    );
  }
}
