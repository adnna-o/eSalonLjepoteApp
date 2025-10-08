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
        backgroundColor: Color.fromARGB(255, 132, 77, 97),
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
                  color: Color.fromARGB(255, 132, 77, 97)),
              SizedBox(width: 8.0),
              Text(
                "Salon ljepote naziv ${_salonLjepote?.nazivSalona}",
                style: TextStyle(
                    color: Color.fromARGB(255, 132, 77, 97), fontSize: 16.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.phone, color: Color.fromARGB(255, 170, 169, 169)),
              SizedBox(width: 8.0),
              Text(
                "${_salonLjepote?.telefon}",
                style: TextStyle(
                    color: Color.fromARGB(255, 132, 77, 97), fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.email, color: Color.fromARGB(255, 132, 77, 97)),
              SizedBox(width: 8.0),
              Text(
                "${_salonLjepote?.email}",
                style: TextStyle(
                    color: Color.fromARGB(255, 132, 77, 97), fontSize: 14.0),
              ),
            ],
          ),
          SizedBox(width: 16.0),
          Row(
            children: [
              Icon(Icons.location_on,
                  color: Color.fromARGB(255, 132, 77, 97)),
              SizedBox(width: 8.0),
              Text(
                "${_salonLjepote?.adresa}",
                style: TextStyle(
                    color: Color.fromARGB(255, 132, 77, 97), fontSize: 14.0),
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
        _buildNavIcon(context, Icons.home, WelcomeScreen(), "Home"),
        _buildNavIcon(context, Icons.schedule, TerminScreen(), "Termini"),
        _buildNavIcon(context, Icons.photo_library, GalerijaScreen(), "Galerija"),
        _buildNavIcon(context, Icons.shopping_bag, ProizvodScreen(), "Proizvodi"),
        _buildNavIcon(context, Icons.newspaper, UslugaNovostiScreen(), "Usluge i novosti"),
        _buildNavIcon(context, Icons.people, KlijentScreen(), "Klijenti"),
        _buildNavIcon(context, Icons.receipt_long, NarudzbaScreen(), "Narudzbe"),
        _buildNavIcon(context, Icons.history, ReportScreen(), "Historija"),
        _buildNavIcon(context, Icons.history, ZaposleniScreen(), "Historija"),

      ],
    );
  }

  Widget _buildNavIcon(BuildContext context, IconData icon, Widget screen, String tooltip) {
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
            color: Color.fromARGB(255, 207, 181, 185),
            size: 50,
          ),
        ),
      ),
    );
  }
}
