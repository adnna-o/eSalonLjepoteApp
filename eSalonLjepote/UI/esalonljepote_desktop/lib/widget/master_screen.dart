import 'package:esalonljepote_desktop/models/salonLjepote.dart';
import 'package:esalonljepote_desktop/providers/salonLjepote_provider.dart';
import 'package:esalonljepote_desktop/screens/galerija_screen.dart';
import 'package:esalonljepote_desktop/screens/home_screen.dart';
import 'package:esalonljepote_desktop/screens/klijent_screen.dart';
import 'package:esalonljepote_desktop/screens/narudzba_screen.dart';
import 'package:esalonljepote_desktop/screens/proizvod_screen.dart';
import 'package:esalonljepote_desktop/screens/report_screen.dart';
import 'package:esalonljepote_desktop/screens/termin_screen.dart';
import 'package:esalonljepote_desktop/screens/usluganovosti_screen.dart';
import 'package:esalonljepote_desktop/screens/zaposleni_screen.dart';
import 'package:esalonljepote_desktop/utils/util.dart';
import 'package:esalonljepote_desktop/main.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;
  MasterScreenWidget({this.child, this.title, this.title_widget, Key? key})
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

  void _logout() {
    Authorization.korisnik = null;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 173, 160, 117),
        automaticallyImplyLeading: false,
        title: widget.title_widget ??
            Text(
              widget.title ?? "",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
        actions: [
          _buildNavBarIcons(context),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: widget.child!),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.local_hospital,
                  color:Color.fromARGB(255, 173, 160, 117)),
              SizedBox(width: 8.0),
              Text(
                "${_salonLjepote?.nazivSalona}",
                style: TextStyle(
                    color:Color.fromARGB(255, 173, 160, 117), fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.phone, color: Color.fromARGB(255, 173, 160, 117)),
              SizedBox(width: 8.0),
              Text(
                "${_salonLjepote?.telefon}",
                style: TextStyle(
                    color: Color.fromARGB(255, 173, 160, 117), fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.email, color:Color.fromARGB(255, 173, 160, 117)),
              SizedBox(width: 8.0),
              Text(
                "${_salonLjepote?.email}",
                style: TextStyle(
                    color:Color.fromARGB(255, 173, 160, 117), fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.location_on, color:Color.fromARGB(255, 173, 160, 117)),
              SizedBox(width: 8.0),
              Text(
                "${_salonLjepote?.adresa}",
                style: TextStyle(
                    color: Color.fromARGB(255, 173, 160, 117), fontSize: 14.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarIcons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavIcon(context, Icons.home, WelcomeScreen(), "Početna"),
        _buildNavIcon(context, Icons.article, UslugaNovostiScreen(),
            "Usluge i novosti"),
        _buildNavIcon(context, Icons.style, ProizvodScreen(), "Proizvodi"),
        _buildNavIcon(context, Icons.image, GalerijaScreen(), "Galerija"),
        _buildNavIcon(context, Icons.calendar_today, TerminScreen(), "Termini"),
        _buildNavIcon(context, Icons.shopping_bag, NarudzbaScreen(), "Narudžbe"),
        _buildNavIcon(context, Icons.face_retouching_natural, KlijentScreen(),
            "Klijenti"),
        _buildNavIcon(context, Icons.people, ZaposleniScreen(), "Zaposleni"),
        _buildNavIcon(context, Icons.history, ReportScreen(), "Historija"),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: _logout,
          child: Text("Odjava", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 79, 6, 6),
          ),
        ),
      ],
    );
  }

  Widget _buildNavIcon(
      BuildContext context, IconData icon, Widget screen, String tooltip) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: Tooltip(
          message: tooltip,
          child: Icon(
            icon,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 25,
          ),
        ),
      ),
    );
  }
}
