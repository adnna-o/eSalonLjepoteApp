import 'dart:async';
import 'package:esalonljepote_desktop/models/klijenti.dart';
import 'package:esalonljepote_desktop/models/search_result.dart';
import 'package:esalonljepote_desktop/models/termini.dart';
import 'package:esalonljepote_desktop/providers/klijenti_provider.dart';
import 'package:esalonljepote_desktop/providers/termini_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class TerminScreen extends StatefulWidget {
  Termini? termini;
  TerminScreen({Key? key, this.termini}) : super(key: key);

  @override
  State<TerminScreen> createState() => _TerminScreen();
}

class _TerminScreen extends State<TerminScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late KlijentiProvider _klijentiProvider;
  late TerminiProvider _terminProvider;
  SearchResult<Termini>? terminResult;
  SearchResult<Klijenti>? klijentiResult;

  bool searchExecuted = false;
  Timer? _debounce;

//Inicijalizacija providera
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _terminProvider = context.read<TerminiProvider>();
    _klijentiProvider = context.read<KlijentiProvider>();
    _fetchTermini(); 
  }

//buduca funkcija
  Future<void> _fetchTermini() async {
    var terminData = await _terminProvider.get();
    var klijentiData = await _klijentiProvider.get();

    setState(() {
      terminResult = terminData;
      klijentiResult = klijentiData;
    });
    print(terminResult);
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        child: Column(
          children: [
            Expanded(child: _buildDataListView()),
          ],
        ),
      ),
    );
  }

  void _refreshTermini() async {
    var terminData = await _terminProvider.get();

    setState(() {
      terminResult = terminData;
    });
  }

  Expanded _buildDataListView() {
    final _verticalScrollController = ScrollController();
    final _horizontalScrollController = ScrollController();

    return Expanded(
      child: Card(
        elevation: 5,
        child:DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'TerminId',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'UslugeId',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'ZaposleniId',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'KlijentId',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Datum termina',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Vrijeme termina',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    
                  ],
                  rows: terminResult?.result.map((Termini e) {

                        return DataRow(
                         
                          cells: [
                            DataCell(Text(e.terminId.toString() ?? "")),
                            DataCell(Text(e.uslugaId.toString() ?? "")),
                            DataCell(Text(e.zaposleniId.toString() ?? "")),
                            DataCell(Text(e?.klijentId.toString() ?? "")),
                            DataCell(Text(e?.datumTermina.toString() ?? "")),
                            DataCell(Text(e?.vrijemeTermina.toString() ?? "")),

                          ],
                        );
                      }).toList() ??
                      [],
                ),
              ),
            );
  }
}