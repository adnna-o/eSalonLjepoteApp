import 'dart:async';
import 'dart:convert';
import 'package:esalonljepote_desktop/models/administrator.dart';
import 'package:esalonljepote_desktop/models/galerija.dart';
import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:esalonljepote_desktop/models/search_result.dart';
import 'package:esalonljepote_desktop/models/zaposleni.dart';
import 'package:esalonljepote_desktop/providers/administrator_provider.dart';
import 'package:esalonljepote_desktop/providers/galerija_provider.dart';
import 'package:esalonljepote_desktop/providers/korisnik_provider.dart';
import 'package:esalonljepote_desktop/providers/zaposleni_provider.dart';
import 'package:esalonljepote_desktop/screens/galerija_details_screen.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';
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
  late AdministratorProvider _administratorProvider;

  SearchResult<Zaposleni>? zaposleniResult;
  SearchResult<Korisnik>? korisnikResult;
  SearchResult<Galerija>? galerijaResult;
  SearchResult<Administrator>? administratorResult;

  bool searchExecuted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _galerijaProvider = context.read<GalerijaProvider>();
    _zaposleniProvider = context.read<ZaposleniProvider>();
    _korisnikProvider = context.read<KorisnikProvider>();
    _administratorProvider = context.read<AdministratorProvider>();

    _fetchGalerija();
  }

  Future<void> _fetchGalerija() async {
    var galerijaData = await _galerijaProvider.get();
    var zaposleniData = await _zaposleniProvider.get();
    var korisnikData = await _korisnikProvider.get();
    var administratorData = await _administratorProvider.get();

    setState(() {
      galerijaResult = galerijaData;
      zaposleniResult = zaposleniData;
      korisnikResult = korisnikData;
      administratorResult = administratorData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Container(
        child: Column(
          children: [
            Expanded(child: _buildDataListView()),
            const SizedBox(
              height: 8.0,
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GalerijaDetailsScreen(
                      onGalerijaUpdated: _fetchGalerija,
                    ),
                  ),
                );
                if (result != null) {
                  _fetchGalerija();
                }
              },
              child: Text("Dodaj sliku!"),
            ),
          ],
        ),
      ),
    );
  }

  void _refreshGalerija() async {
    var galerijaData = await _galerijaProvider.get();

    setState(() {
      galerijaResult = galerijaData;
    });
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
        maxCrossAxisExtent: 200, 
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 3 / 4,
      ),
      itemBuilder: (context, index) {
        final galerija = galerijaResult!.result[index];

        var administrator = administratorResult?.result.firstWhere(
            (p) => p.administratorId == galerija.administratorId,
            orElse: () => Administrator());

        var korisnik =
            administrator != null && administrator.korisnikId != null
                ? korisnikResult?.result.firstWhere(
                    (k) => k.korisnikId == administrator.korisnikId,
                    orElse: () => Korisnik(ime: "Nepoznato"))
                : null;

        String adminIme = korisnik?.ime ?? "Nepoznato";

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: Colors.greenAccent.withOpacity(0.4),
            child: InkWell(
              onTap: () {
              },
              borderRadius: BorderRadius.circular(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: galerija.slika != null && galerija.slika!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                            child: Image.memory(
                              base64Decode(galerija.slika!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            child: const Center(child: Text('Nema slike')),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
}
