import 'package:esalonljepote_mobile/models/klijenti.dart';
import 'package:esalonljepote_mobile/models/korisnik.dart';
import 'package:esalonljepote_mobile/models/ocjene_proizvoda.dart';
import 'package:esalonljepote_mobile/models/salonLjepote.dart';
import 'package:esalonljepote_mobile/models/search_result.dart';
import 'package:esalonljepote_mobile/models/usluga.dart';
import 'package:esalonljepote_mobile/models/zaposleni.dart';
import 'package:esalonljepote_mobile/providers/klijenti_provider.dart';
import 'package:esalonljepote_mobile/providers/korisnik_provider.dart';
import 'package:esalonljepote_mobile/providers/salonLjepote_provider.dart';
import 'package:esalonljepote_mobile/providers/usluga_provider.dart';
import 'package:esalonljepote_mobile/providers/zaposleni_provider.dart';
import 'package:esalonljepote_mobile/screens/galerija_screen.dart';
import 'package:esalonljepote_mobile/screens/home_screen.dart';
import 'package:esalonljepote_mobile/screens/korisnik_screen.dart';
import 'package:esalonljepote_mobile/screens/korpa_screen.dart';
import 'package:esalonljepote_mobile/screens/ocjene_details_screen.dart';
import 'package:esalonljepote_mobile/screens/ocjene_tima_screen.dart';
import 'package:esalonljepote_mobile/screens/preporuceni_proizvodi_screen.dart';
import 'package:esalonljepote_mobile/screens/proizvod_screen.dart';
import 'package:esalonljepote_mobile/screens/termini_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MasterScreenWidget extends StatefulWidget {
  final Widget? child;
  final String? title;
  final Widget? title_widget;

  const MasterScreenWidget({this.child, this.title, this.title_widget, Key? key})
      : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  late SalonLjepoteProvider _salonLjepoteProvider;
  SalonLjepote? _salonLjepote;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _salonLjepoteProvider = context.read<SalonLjepoteProvider>();
    _fetchSalonLjepoteDetails();
  }

  Future<void> _fetchSalonLjepoteDetails() async {
    var data = await _salonLjepoteProvider.get();
    setState(() {
      _salonLjepote = data.result?.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Column(
          children: [
            // Glavni sadržaj
            Expanded(
              child: widget.child ?? Container(),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 500;

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: isSmallScreen ? 8 : 16,
                    runSpacing: isSmallScreen ? 8 : 10,
                    children: [
                      _buildNavIcon(context, Icons.home, HomeScreen(), "Home"),
                      _buildNavIcon(
                          context, Icons.schedule, TerminScreen(), "Termini"),
                      _buildNavIcon(context, Icons.photo_library, ProizvodScreen(),
                          "Proizvodi"),
                      _buildNavIcon(context, Icons.shopping_bag,
                          PreporuceniProizvodiScreen(), "Preporučeni"),
                      _buildNavIcon(context, Icons.shopping_cart, CartScreen(),
                          "Korpa"),
                      _buildNavIcon(context, Icons.image, GalerijaScreen(),
                          "Galerija"),
                      _buildNavIcon(context, Icons.star_rate,
                          OcjenaProizvodDetailsScreen(), "Ocjene proizvoda"),
                      _buildNavIcon(context, Icons.people_alt, OcjeneTimaScreen(),
                          "Ocjene tima"),
                      _buildNavIcon(context, Icons.person,
                          KorisnikProfileScreen(), "Korisnik profil"),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(
      BuildContext context, IconData icon, Widget screen, String tooltip) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      borderRadius: BorderRadius.circular(50),
      child: Tooltip(
        message: tooltip,
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 240, 240),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 6,
                offset: const Offset(2, 3),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: const Color.fromARGB(255, 207, 181, 185),
            size: 32,
          ),
        ),
      ),
    );
  }
}
