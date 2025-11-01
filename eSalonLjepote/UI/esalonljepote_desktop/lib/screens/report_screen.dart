import 'dart:convert';
import 'dart:io';
import 'package:esalonljepote_desktop/models/narudzba.dart';
import 'package:esalonljepote_desktop/providers/korisnik_provider.dart';
import 'package:esalonljepote_desktop/providers/narudzba_provider.dart';
import 'package:esalonljepote_desktop/providers/proizvod_provider.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreen();
}

class _ReportScreen extends State<ReportScreen> {
  late Future<List<Narudzba>> futureHistorija;

  DateTime? _selectedDate;
  final TextEditingController _kupacController = TextEditingController();
  final TextEditingController _iznosOdController = TextEditingController();
  final TextEditingController _iznosDoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  void _loadReport() {
    Map<String, dynamic> filter = {};

    if (_selectedDate != null) {
      filter['DatumNarudzbe'] = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    }
    if (_kupacController.text.trim().isNotEmpty) {
      filter['KupacImePrezime'] = _kupacController.text.trim();
    }
    if (_iznosOdController.text.trim().isNotEmpty) {
      filter['IznosOd'] =
          double.tryParse(_iznosOdController.text.trim()) ?? 0.0;
    }
    if (_iznosDoController.text.trim().isNotEmpty) {
      filter['IznosDo'] =
          double.tryParse(_iznosDoController.text.trim()) ?? double.maxFinite;
    }

    setState(() {
      futureHistorija = context
          .read<NarudzbaProvider>()
          .getIzvjestajHistorijeNarudzbi(filter: filter);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _kupacController.dispose();
    _iznosOdController.dispose();
    _iznosDoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    return MasterScreenWidget(
      title: "Historija narudžbi sa filterima",
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Datum narudžbe',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        _selectedDate != null
                            ? dateFormat.format(_selectedDate!)
                            : 'Odaberi datum',
                        style: TextStyle(
                            color: _selectedDate != null
                                ? Colors.black
                                : Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _kupacController,
                    decoration: InputDecoration(
                      labelText: 'Ime ili prezime kupca',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _iznosOdController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Iznos od',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _iznosDoController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Iznos do',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _loadReport();
                  },
                  child: Text('Primijeni filtere'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    final rawNarudzbe = await context
                        .read<NarudzbaProvider>()
                        .getIzvjestajHistorijeNarudzbi(filter: {
                      if (_selectedDate != null)
                        'DatumNarudzbe':
                            DateFormat('yyyy-MM-dd').format(_selectedDate!),
                      if (_kupacController.text.trim().isNotEmpty)
                        'KupacImePrezime': _kupacController.text.trim(),
                      if (_iznosOdController.text.trim().isNotEmpty)
                        'IznosOd':
                            double.tryParse(_iznosOdController.text.trim()) ??
                                0.0,
                      if (_iznosDoController.text.trim().isNotEmpty)
                        'IznosDo':
                            double.tryParse(_iznosDoController.text.trim()) ??
                                double.maxFinite,
                    });

                    final narudzbeSaProizvodima =
                        await _loadNarudzbeSaProizvodima(rawNarudzbe);
                    final narudzbeSaKupcima =
                        await _loadNarudzbeSaKupcem(rawNarudzbe);

                    await _generatePdfHistorija('Filtrirane_narudzbe',
                        narudzbeSaProizvodima, narudzbeSaKupcima);
                  },
                  child: Text('Generiraj PDF izvještaj'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Narudzba>>(
                future: futureHistorija,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Greška pri učitavanju podataka'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Nema historijskih narudžbi'));
                  }
                  final list = snapshot.data!;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final nar = list[index];
                      String kupac = nar.korisnik != null
                          ? nar.korisnik!
                              .map((k) => "${k.ime ?? ''} ${k.prezime ?? ''}")
                              .join(', ')
                          : '';
                      final dateFormat = DateFormat('yyyy-MM-dd');
                      String datum = nar.datumNarudzbe != null
                          ? dateFormat.format(nar.datumNarudzbe!)
                          : '';

                      String iznos =
                          nar.iznosNarudzbe?.toStringAsFixed(2) ?? '0.00';
                      return ListTile(
                        title: Text(kupac),
                        subtitle: Text('Datum: $datum — Iznos: $iznos'),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Narudzba>> _loadNarudzbeSaProizvodima(
      List<Narudzba> narudzbe) async {
    final proizvodProvider = context.read<ProizvodProvider>();

    for (var nar in narudzbe) {
      if (nar.proizvodId != null) {
        final proizvod = await proizvodProvider.getById(nar.proizvodId!);
        nar.proizvod = [proizvod];
      }
    }
    return narudzbe;
  }

  Future<List<Narudzba>> _loadNarudzbeSaKupcem(List<Narudzba> narudzbe) async {
    final _korisnikProvider = context.read<KorisnikProvider>();

    for (var kupac in narudzbe) {
      if (kupac.korisnikId != null) {
        final kupci = await _korisnikProvider.getById(kupac.korisnikId!);
        kupac.korisnik = [kupci];
      }
    }
    return narudzbe;
  }

  Future<void> _generatePdfHistorija(String reportName, List<Narudzba> data,
      List<Narudzba> narudzbeSaKupcima) async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/fonts/ttf/DejaVuSans.ttf');
    final ttf = pw.Font.ttf(fontData);
    final dateFormat = DateFormat('dd.MM.yyyy');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                reportName,
                style: pw.TextStyle(
                    fontSize: 24, fontWeight: pw.FontWeight.bold, font: ttf),
              ),
            ),
            pw.Paragraph(
              text: "Datum generiranja: ${dateFormat.format(DateTime.now())}",
              style: pw.TextStyle(
                  fontSize: 12, fontStyle: pw.FontStyle.italic, font: ttf),
            ),
            pw.SizedBox(height: 20),
            _buildTableHistorija(data, ttf),
          ];
        },
      ),
    );

    try {
      final outputDir = await getApplicationDocumentsDirectory();
      final filePath = '${outputDir.path}/$reportName.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());
      print('PDF spremljen na $filePath');
      _showReportDownloadedDialog(filePath);
    } catch (e) {
      print('Greška pri spremanju PDF: $e');
    }
  }

  pw.Widget _buildTableHistorija(List<Narudzba> data, pw.Font ttf) {
    final headers = ['Kupac', 'Datum kupovine', 'Sadržaj narudžbe', 'Iznos'];
    final dateFormat = DateFormat('dd.MM.yyyy');
    final dataRows = data.map((nar) {
      String kupac = nar.korisnik!
          .map((k) => "${k.ime ?? ''} ${k.prezime ?? ''}")
          .join(', ');

      String datum = nar.datumNarudzbe != null
          ? dateFormat.format(nar.datumNarudzbe!)
          : '';
      String proizvod = nar.proizvod!
          .map((k) =>
              "Naziv proizvoda: ${k.nazivProizvoda ?? ''} \n Cijena: ${k.cijena ?? ''} \n")
          .join(', ');

      String iznos = nar.iznosNarudzbe?.toStringAsFixed(2) ?? '0.00';

      print('Proizvod polje: ${kupac}');

      return [kupac, datum, proizvod, iznos];
    }).toList();

    return pw.Table.fromTextArray(
      headers: headers,
      data: dataRows,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, font: ttf),
      cellStyle: pw.TextStyle(font: ttf),
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
      border: pw.TableBorder.all(width: 0.5, color: PdfColors.grey),
      columnWidths: {
        0: pw.FlexColumnWidth(2),
        1: pw.FlexColumnWidth(1.5),
        2: pw.FlexColumnWidth(3),
        3: pw.FlexColumnWidth(1),
      },
    );
  }

  void _showReportDownloadedDialog(String filePath) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Izvještaj generisan'),
        content: Text('PDF je spremljen na:\n$filePath'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}
