import 'dart:async';
import 'dart:convert';
import 'package:esalonljepote_desktop/models/proizvod.dart';
import 'package:esalonljepote_desktop/models/search_result.dart';
import 'package:esalonljepote_desktop/providers/proizvod_provider.dart';
import 'package:esalonljepote_desktop/screens/proizvod_datails_screen.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class ProizvodScreen extends StatefulWidget {
  ProizvodScreen({Key? key}) : super(key: key);

  @override
  State<ProizvodScreen> createState() => _ProizvodScreenState();
}

class _ProizvodScreenState extends State<ProizvodScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late ProizvodProvider _proizvodProvider;
  SearchResult<Proizvod>? proizvodResult;

  final TextEditingController _nazivController = TextEditingController();
  Timer? _debounce;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _proizvodProvider = context.read<ProizvodProvider>();
    _fetchProizvodi();
  }

  Future<void> _fetchProizvodi() async {
    var data = await _proizvodProvider.get();
    setState(() {
      proizvodResult = data;
    });
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      var data = await _proizvodProvider.get(
        filter: {'nazivProizvoda': _nazivController.text.trim()},
      );
      setState(() {
        proizvodResult = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8F8F8), Color(0xFFEFEFEF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            Expanded(child: _buildProizvodiGrid()),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 173, 160, 117),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Dodaj novi proizvod",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProizvodDetailsScreen(
                      onProizvodUpdated: _fetchProizvodi,
                    ),
                  ),
                );
                if (result != null) _fetchProizvodi();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color.fromARGB(255, 173, 160, 117)),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _nazivController,
                onChanged: (_) => _onSearchChanged(),
                decoration: const InputDecoration(
                  hintText: "Pretraži proizvode...",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _nazivController.clear();
                _fetchProizvodi();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProizvodiGrid() {
    if (proizvodResult == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final proizvodi = proizvodResult!.result;

    if (proizvodi.isEmpty) {
      return const Center(
        child: Text("Nema dostupnih proizvoda."),
      );
    }

    return GridView.builder(
      itemCount: proizvodi.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // broj kolona
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final p = proizvodi[index];

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProizvodDetailsScreen(
                    proizvod: p,
                    onProizvodUpdated: _fetchProizvodi,
                  ),
                ),
              );
              if (result != null) _fetchProizvodi();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: p.slika != null && p.slika!.isNotEmpty
                          ? Image.memory(
                              base64Decode(p.slika!),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.image_not_supported,
                                  size: 50, color: Colors.grey),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          p.nazivProizvoda ?? "Nepoznato",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${p.cijena?.toStringAsFixed(2) ?? '--'} KM",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 173, 160, 117),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
