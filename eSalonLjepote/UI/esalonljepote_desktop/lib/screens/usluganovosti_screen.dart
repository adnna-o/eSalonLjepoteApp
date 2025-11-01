import 'dart:async';
import 'dart:convert';
import 'package:esalonljepote_desktop/models/novosti.dart';
import 'package:esalonljepote_desktop/models/search_result.dart';
import 'package:esalonljepote_desktop/models/usluga.dart';
import 'package:esalonljepote_desktop/providers/novosti_provider.dart';
import 'package:esalonljepote_desktop/providers/usluga_provider.dart';
import 'package:esalonljepote_desktop/screens/novosti_details_screen.dart';
import 'package:esalonljepote_desktop/screens/usluga_details_screen.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UslugaNovostiScreen extends StatefulWidget {
  Usluga? usluga;
  Novosti? novosti;
  UslugaNovostiScreen({Key? key, this.usluga, this.novosti}) : super(key: key);

  @override
  State<UslugaNovostiScreen> createState() => _UslugaNovostiScreen();
}

class _UslugaNovostiScreen extends State<UslugaNovostiScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late UslugaProvider _uslugaProvider;
  late NovostiProvider _novostiProvider;

  SearchResult<Usluga>? uslugaResult;
  SearchResult<Novosti>? novostiResult;

  bool searchExecuted = false;
  Timer? _debounce;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _uslugaProvider = context.read<UslugaProvider>();
    _novostiProvider = context.read<NovostiProvider>();

    _fetchNovosti();
    _fetchUsluga();
  }

  Future<void> _fetchNovosti() async {
    var novostiData = await _novostiProvider.get();

    setState(() {
      novostiResult = novostiData;
    });
  }

  Future<void> _fetchUsluga() async {
    var uslugaData = await _uslugaProvider.get();

    setState(() {
      uslugaResult = uslugaData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Container(
        child: Column(
          children: [
            Expanded(child: _buildUslugaListView()),
            const SizedBox(
              height: 8.0,
            ),
            Expanded(child: _buildNovostiListView()),
            const SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }

  void _refreshUsluga() async {
    var uslugaData = await _uslugaProvider.get();

    setState(() {
      uslugaResult = uslugaData;
    });
  }

  void _refreshNovosti() async {
    var novostiData = await _novostiProvider.get();

    setState(() {
      novostiResult = novostiData;
    });
  }

  Widget _buildUslugaListView() {
    if (uslugaResult == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final controller = PageController(viewportFraction: 0.3);
    final usluge = uslugaResult!.result;

    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (controller.hasClients && usluge.isNotEmpty) {
        int nextPage = controller.page!.round() + 1;
        if (nextPage >= usluge.length) nextPage = 0;
        controller.animateToPage(nextPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut);
      }
    });

    return SizedBox(
      height: 260,
      child: PageView.builder(
        controller: controller,
        itemCount: usluge.length + 1,
        itemBuilder: (context, index) {
          if (index == usluge.length) {
            return GestureDetector(
              onTap: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UslugaDetailsScreen(
                      onUslugaUpdate: _fetchUsluga,
                    ),
                  ),
                );
                if (result != null) _fetchUsluga();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Color.fromARGB(255, 173, 160, 117), width: 2),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add,
                          size: 50, color: Color.fromARGB(255, 173, 160, 117)),
                      SizedBox(height: 10),
                      Text(
                        "Dodaj novu uslugu",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 173, 160, 117),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final e = usluge[index];

          return GestureDetector(
            onTap: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UslugaDetailsScreen(
                    usluga: e, 
                    onUslugaUpdate: _fetchUsluga, 
                  ),
                ),
              );
              if (result != null) _fetchUsluga();
            },
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage('assets/images/homepage.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(135, 132, 132, 132), BlendMode.lighten),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(2, 2)),
                ],
              ),
              child: Card(
                color: Colors.transparent,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        e.nazivUsluge ?? '',
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${e.cijena} KM',
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Trajanje: ${e.trajanje} min',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNovostiListView() {
    if (novostiResult == null) {
      return Center(child: CircularProgressIndicator());
    }

    final controller = PageController(viewportFraction: 0.4);
    final novosti = novostiResult!.result;

    Timer.periodic(Duration(seconds: 3), (timer) {
      if (controller.hasClients && novosti.isNotEmpty) {
        int nextPage = controller.page!.round() + 1;
        if (nextPage >= novosti.length) nextPage = 0;
        controller.animateToPage(nextPage,
            duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
      }
    });

    return SizedBox(
      height: 250,
      child: PageView.builder(
        controller: controller,
        itemCount: novosti.length + 1,
        itemBuilder: (context, index) {
          if (index == novosti.length) {
            return GestureDetector(
              onTap: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NovostiDetailsScreen(
                      onDataChanged: _fetchNovosti,
                    ),
                  ),
                );
                if (result != null) _fetchNovosti();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 173, 160, 117), width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add,
                          size: 50, color: Color.fromARGB(255, 173, 160, 117)),
                      SizedBox(height: 10),
                      Text(
                        "Dodaj nove novosti",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 173, 160, 117),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          final e = novosti[index];

          return GestureDetector(
            onTap: () async{
              final result= await Navigator.of(context).push(MaterialPageRoute(builder: (context)=> NovostiDetailsScreen(
                novosti: e,
                onDataChanged: _fetchNovosti,
              ),),);
              if(result!= null) _fetchNovosti();
            },
          
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [Colors.white, Colors.purple.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(2, 2))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.newspaper,
                      size: 40, color: Color.fromARGB(255, 173, 160, 117)),
                  const SizedBox(height: 10),
                  Text(
                    e.naziv ?? '',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 188, 131, 41)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    e.opisNovisti ?? '',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Datum: ${e.datumObjave != null ? DateFormat('dd.MM.yyyy').format(DateTime.parse(e.datumObjave.toString()!)) : 'Nepoznato'}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: e.aktivna == 1,
                        onChanged: null,
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),);
        },
      ),
    );
  }
}
