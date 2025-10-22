import 'package:esalonljepote_mobile/models/klijenti.dart';
import 'package:esalonljepote_mobile/models/korisnik.dart';
import 'package:esalonljepote_mobile/models/salonLjepote.dart';
import 'package:esalonljepote_mobile/models/search_result.dart';
import 'package:esalonljepote_mobile/models/usluga.dart';
import 'package:esalonljepote_mobile/models/zaposleni.dart';
import 'package:esalonljepote_mobile/providers/klijenti_provider.dart';
import 'package:esalonljepote_mobile/providers/korisnik_provider.dart';
import 'package:esalonljepote_mobile/providers/salonLjepote_provider.dart';
import 'package:esalonljepote_mobile/providers/usluga_provider.dart';
import 'package:esalonljepote_mobile/providers/zaposleni_provider.dart';
import 'package:esalonljepote_mobile/screens/home_screen.dart';
import 'package:esalonljepote_mobile/screens/korpa_screen.dart';
import 'package:esalonljepote_mobile/screens/preporuceni_proizvodi_screen.dart';
import 'package:esalonljepote_mobile/screens/proizvod_screen.dart';
import 'package:esalonljepote_mobile/screens/termini_screen.dart';
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
              Icon(Icons.location_on, color: Color.fromARGB(255, 132, 77, 97)),
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
        _buildNavIcon(context, Icons.home, HomeScreen(), "Home"),
        _buildNavIcon(context, Icons.schedule, TerminScreen(), "Termini"),
        _buildNavIcon(context, Icons.photo_library, ProizvodScreen(), "Pregled prozivoda"),
        _buildNavIcon(context, Icons.shopping_bag, PreporuceniProizvodiScreen(), "Preppruceni"),
        _buildNavIcon(
            context, Icons.newspaper, CartScreen(), "Korpa"),
        _buildNavIcon(context, Icons.people, HomeScreen(), "Klijenti"),
        _buildNavIcon(context, Icons.receipt_long, HomeScreen(), "Narudzbe"),
        _buildNavIcon(context, Icons.history, HomeScreen(), "Historija"),
        _buildNavIcon(context, Icons.people_alt, HomeScreen(), "Zaposleni"),
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
            color: Color.fromARGB(255, 207, 181, 185),
            size: 50,
          ),
        ),
      ),
    );
  }
}
