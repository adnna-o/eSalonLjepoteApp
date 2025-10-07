import 'package:esalonljepote_desktop/models/salonLjepote.dart';
import 'package:esalonljepote_desktop/providers/salonLjepote_provider.dart';
import 'package:esalonljepote_desktop/screens/galerija_screen.dart';
import 'package:esalonljepote_desktop/screens/home_screen.dart';
import 'package:esalonljepote_desktop/screens/klijent_screen.dart';
import 'package:esalonljepote_desktop/screens/narudzba_screen.dart';
import 'package:esalonljepote_desktop/screens/proizvod_screen.dart';
import 'package:esalonljepote_desktop/screens/termin_screen.dart';
import 'package:esalonljepote_desktop/screens/usluganovosti_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 125, 137),
        automaticallyImplyLeading: false,
        title: widget.title_widget ??
            Text(
              widget.title ?? "",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
        actions: [
          _buildNavBarItems(context),
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
                  color: const Color.fromARGB(255, 63, 125, 137)),
              SizedBox(width: 8.0),
              Text(
                "Salon ljepote naziv ${_salonLjepote?.nazivSalona}",
                style: TextStyle(
                    color: const Color.fromARGB(255, 63, 125, 137),
                    fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.phone, color: const Color.fromARGB(255, 63, 125, 137)),
              SizedBox(width: 8.0),
              Text(
                "${_salonLjepote?.telefon}",
                style: TextStyle(
                    color: const Color.fromARGB(255, 63, 125, 137),
                    fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.email, color: const Color.fromARGB(255, 63, 125, 137)),
              SizedBox(width: 8.0),
              Text(
                "${_salonLjepote?.email}",
                style: TextStyle(
                    color: const Color.fromARGB(255, 63, 125, 137),
                    fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.location_on,
                  color: const Color.fromARGB(255, 63, 125, 137)),
              SizedBox(width: 8.0),
              Text(
                "${_salonLjepote?.adresa}",
                style: TextStyle(
                    color: const Color.fromARGB(255, 63, 125, 137),
                    fontSize: 14.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItems(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildNavText(context, "Home", WelcomeScreen()),
        _buildNavText(context, "Termini", TerminScreen()),
        _buildNavText(context, "Galerija", GalerijaScreen()),
        _buildNavText(context, "Proizvodi", ProizvodScreen()),
        _buildNavText(context, "Usluge i novosti", UslugaNovostiScreen()),
      // _buildNavText(context, "Novosti", WelcomeScreen()),
        _buildNavText(context, "Klijenti", KlijentScreen()),
        _buildNavText(context, "Narudzbe", NarudzbaScreen()),
        _buildNavText(context, "Historija", WelcomeScreen()),
      ],
    );
  }

  Widget _buildNavText(BuildContext context, String title, Widget screen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        onHover: (isHovered) {
          setState(() {});
        },
        child: MouseRegion(
          onEnter: (_) {
            setState(() {});
          },
          onExit: (_) {
            setState(() {});
          },
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}