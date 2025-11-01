import 'dart:convert';
import 'package:esalonljepote_desktop/models/administrator.dart';
import 'package:esalonljepote_desktop/models/galerija.dart';
import 'package:esalonljepote_desktop/models/proizvod.dart';
import 'package:esalonljepote_desktop/models/usluga.dart';
import 'package:esalonljepote_desktop/providers/administrator_provider.dart';
import 'package:esalonljepote_desktop/providers/galerija_provider.dart';
import 'package:esalonljepote_desktop/providers/proizvod_provider.dart';
import 'package:esalonljepote_desktop/providers/usluga_provider.dart';
import 'package:esalonljepote_desktop/screens/usluganovosti_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../models/search_result.dart';

class UslugaDetailsScreen extends StatefulWidget {
  final Usluga? usluga;
  final Function()? onUslugaUpdate;

  const UslugaDetailsScreen({Key? key, this.usluga, this.onUslugaUpdate})
      : super(key: key);

  @override
  State<UslugaDetailsScreen> createState() => _UslugaDetailsScreenState();
}

class _UslugaDetailsScreenState extends State<UslugaDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late UslugaProvider _uslugaProvider;

  SearchResult<Usluga>? uslugaResult;

  bool _isLoading = true;

  bool get _isEdit => widget.usluga != null;

  @override
  void initState() {
    super.initState();
    _uslugaProvider = context.read<UslugaProvider>();
    _initForm();
  }

  bool _hasUnsavedChanges = false;

  Future<void> _initForm() async {
    uslugaResult = await _uslugaProvider.get();

    setState(() => _isLoading = false);
  }

  Future<bool> _confirmDiscardIfNeeded() async {
    if (!_hasUnsavedChanges) return true;

    final discard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Odbaciti promjene?"),
        content: const Text(
            "Napravili ste izmjene koje nisu spašene. Želite li odustati i odbaciti promjene?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Nastavi uređivanje"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Odbaci"),
          ),
        ],
      ),
    );

    return discard ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final screenTitle =
        _isEdit ? (widget!.usluga?.uslugaId ?? "Usluga") : 'Usluga';

    return WillPopScope(
      onWillPop: () async {
        return await _confirmDiscardIfNeeded();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () async {
            final canLeave = await _confirmDiscardIfNeeded();
            if (canLeave) Navigator.of(context).pop(false);
          }),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  _buildForm(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: OutlinedButton(
                          onPressed: () async {
                            final canLeave = await _confirmDiscardIfNeeded();
                            if (canLeave) Navigator.of(context).pop(false);
                          },
                          child: const Text("Odustani"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _onSavePressed,
                          child: Text(_isEdit ? "Spasi" : "Dodaj"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _onSavePressed() async {
    final valid = _formKey.currentState?.saveAndValidate() ?? false;
    if (!valid) {
      _showSnackbar("Provjerite formu i pokušajte ponovo.");
      return;
    }

    final request = Map<String, dynamic>.from(_formKey.currentState!.value);
    final naziv = (request['nazivUsluge'] ?? '').toString().trim();
    request['nazivUsluge'] = naziv;

    final cijenaRaw = request['cijena'];
    double? cijena;

    if (cijenaRaw is double) {
      cijena = cijenaRaw;
    } else if (cijenaRaw is String) {
      cijena = double.tryParse(cijenaRaw.replaceAll(',', '.').trim());
    }

    if (cijena == null || cijena <= 0) {
      _formKey.currentState?.fields['cijena']
          ?.invalidate('Unesite cijenu veću od 0 (npr. 12.50).');
      _showSnackbar("Cijena mora biti veća od 0.");
      return;
    }

    request['cijena'] = cijena;

    final trajanjeUsluge = (request['trajanje'] ?? '').toString().trim();
    request['trajanje'] = trajanjeUsluge;

    try {
      if (_isEdit) {
        await _uslugaProvider.update(widget.usluga!.uslugaId!, request);
        _showSnackbar("Usluga uspjesno uređena.");
      } else {
        await _uslugaProvider.insert(request);
        _showSnackbar("Usluga uspješno dodana.");
      }

      widget.onUslugaUpdate?.call();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  FormBuilder _buildForm() {
    return FormBuilder(
        key: _formKey,
        initialValue: {
          'uslugaId': widget.usluga?.uslugaId?.toString(),
          'nazivUsluge': widget.usluga?.nazivUsluge,
          'cijena': widget.usluga?.cijena.toString(),
          'trajanje': widget.usluga?.trajanje,
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: "nazivUsluge",
                      decoration: InputDecoration(
                        labelText: "Naziv usluga*",
                        labelStyle: const TextStyle(color: Colors.orangeAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.orangeAccent),
                        ),
                      ),
                      validator: (v) {
                        final val = (v ?? '').trim();
                        if (val.isEmpty) return 'Naziv je obavezan.';
                        if (val.length < 2)
                          return 'Naziv mora imati min. 2 znaka.';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormBuilderTextField(
                          name: 'cijena',
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: InputDecoration(
                            labelText: 'Cijena *',
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Colors.orange, width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.red, width: 1),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                            prefixIcon: const Icon(Icons.euro,
                                color: Colors.orangeAccent),
                          ),
                          validator: (v) {
                            final raw = (v ?? '').trim().replaceAll(',', '.');
                            final d = double.tryParse(raw);
                            if (raw.isEmpty) return 'Cijena je obavezna.';
                            if (d == null) return 'Unesite ispravan broj.';
                            if (d <= 0) return 'Cijena mora biti veća od 0.';
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: "trajanje",
                      decoration: InputDecoration(
                        labelText: "Trajanje usluge*",
                        labelStyle: const TextStyle(color: Colors.orangeAccent),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:
                              const BorderSide(color: Colors.orangeAccent),
                        ),
                      ),
                      validator: (v) {
                        final val = (v ?? '').trim();
                        if (val.isEmpty) return 'Naziv je obavezan.';
                        if (val.length < 2)
                          return 'Naziv mora imati min. 2 znaka.';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title:
            const Text("Greška", style: TextStyle(color: Colors.orangeAccent)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text("OK", style: TextStyle(color: Colors.orangeAccent)),
          )
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.orangeAccent,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
