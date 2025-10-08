import 'dart:convert';
import 'package:esalonljepote_desktop/models/administrator.dart';
import 'package:esalonljepote_desktop/models/galerija.dart';
import 'package:esalonljepote_desktop/models/proizvod.dart';
import 'package:esalonljepote_desktop/providers/administrator_provider.dart';
import 'package:esalonljepote_desktop/providers/galerija_provider.dart';
import 'package:esalonljepote_desktop/providers/proizvod_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import '../models/search_result.dart';

class ProizvodDetailsScreen extends StatefulWidget {
  final Proizvod? proizvod;
  final Function()? onProizvodUpdated;

  const ProizvodDetailsScreen({Key? key, this.proizvod, this.onProizvodUpdated})
      : super(key: key);

  @override
  State<ProizvodDetailsScreen> createState() => _ProizvodDetailsScreenState();
}

class _ProizvodDetailsScreenState extends State<ProizvodDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late ProizvodProvider _proizvodProvider;

  SearchResult<Proizvod>? _proizvodResult;

  bool _isLoading = true;

  final ImagePicker _picker = ImagePicker();
  String? _base64Image;
  bool _removeImage = false;

  bool get _isEdit => widget.proizvod != null;

  @override
  void initState() {
    super.initState();
    _proizvodProvider = context.read<ProizvodProvider>();
    _initForm();
  }

  bool _hasUnsavedChanges = false;

  Future<void> _initForm() async {
    _proizvodResult = await _proizvodProvider.get();

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
  @override
  Widget build(BuildContext context) {
    final screenTitle =
        _isEdit ? (widget!.proizvod?.proizvodId ?? "Proizvod") : 'Proizvod';

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
    final naziv = (request['nazivProizvoda'] ?? '').toString().trim();
    request['nazivProizvoda'] = naziv;

    final cijenaStr =
        (request['cijena'] ?? '').toString().replaceAll(',', '.').trim();
    final cijena = double.tryParse(cijenaStr);
    if (cijena == null || cijena <= 0) {
      _formKey.currentState?.fields['cijena']
          ?.invalidate('Unesite cijenu veću od 0 (npr. 12.50).');
      _showSnackbar("Cijena mora biti veća od 0.");
      return;
    }
    request['cijena'] = cijena;

    if (_base64Image != null && _base64Image!.isNotEmpty) {
      request['slika'] = _base64Image;
      request.remove('removeImage');
    } else if (_isEdit && _removeImage) {
      request['slika'] = null;
      request['removeImage'] = true;
    } else if (_isEdit) {
      request.remove('slika');
      request.remove('removeImage');
    } else {
      request.remove('slika');
      request.remove('removeImage');
    }

    try {
      if (_isEdit) {
        await _proizvodProvider.update(widget.proizvod!.proizvodId!, request);
        _showSnackbar("Proizvod je uspješno uređeno.");
      } else {
        await _proizvodProvider.insert(request);
        _showSnackbar("Proizvod je uspješno dodano.");
      }

      widget.onProizvodUpdated?.call();
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  FormBuilder _buildForm() {
    return FormBuilder(
        key: _formKey,
        initialValue: {
          'proizvodId': widget.proizvod?.proizvodId?.toString(),
          'nazivProizvoda': widget.proizvod?.nazivProizvoda,
          'slika': widget.proizvod?.slika,
          'cijena': widget.proizvod?.cijena,
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: "nazivProizvoda",
                      decoration: InputDecoration(
                        labelText: "Naziv *",
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
                    child: FormBuilderField<String?>(
                      name: 'imageId',
                      validator: null,
                      builder: (field) {
                        final hasNewImage =
                            _base64Image != null && _base64Image!.isNotEmpty;
                        final hasExistingImage = !_removeImage &&
                            widget.proizvod?.slika != null &&
                            widget.proizvod!.slika!.isNotEmpty;

                        Widget content;
                        if (hasNewImage) {
                          content = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _imagePreview(_base64Image!),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: _pickImage,
                                    icon: const Icon(Icons.edit),
                                    label: const Text('Promijeni sliku'),
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: _clearNewImage,
                                    icon: const Icon(Icons.delete_outline),
                                    label: const Text('Ukloni'),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (hasExistingImage) {
                          content = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _imagePreview(widget.proizvod!.slika!),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: [
                                  OutlinedButton.icon(
                                    onPressed: _pickImage,
                                    icon: const Icon(Icons.edit),
                                    label: const Text('Promijeni sliku'),
                                  ),
                                  OutlinedButton.icon(
                                    onPressed: _markRemoveExistingImage,
                                    icon: const Icon(Icons.delete_outline),
                                    label: const Text('Ukloni'),
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else {
                          content = ListTile(
                            leading: const Icon(Icons.photo,
                                color: Colors.orangeAccent),
                            title: const Text("Odaberite sliku"),
                            trailing: const Icon(Icons.file_upload,
                                color: Colors.orangeAccent),
                            onTap: _pickImage,
                          );
                        }

                        return InputDecorator(
                          decoration: InputDecoration(
                            label: const Text('Slika (opcionalno)'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.orangeAccent),
                            ),
                          ),
                          child: content,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
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
          ],
        ));
  }

  Widget _imagePreview(String b64) {
    return Container(
      constraints:
          const BoxConstraints(maxHeight: 200, maxWidth: double.infinity),
      child: Image.memory(base64Decode(b64), fit: BoxFit.cover),
    );
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _base64Image = base64Encode(bytes);
        _removeImage = false;
      });
      _formKey.currentState?.fields['imageId']?.reset();
    }
  }

  void _clearNewImage() {
    setState(() {
      _base64Image = null;
    });
  }

  void _markRemoveExistingImage() {
    setState(() {
      _removeImage = true;
      _base64Image = null;
    });
    _formKey.currentState?.fields['imageId']?.reset();
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
