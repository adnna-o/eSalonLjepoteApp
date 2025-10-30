import 'dart:convert';

import 'package:esalonljepote_mobile/main.dart';
import 'package:esalonljepote_mobile/models/korisnik.dart';
import 'package:esalonljepote_mobile/providers/korisnik_provider.dart';
import 'package:esalonljepote_mobile/providers/uloga_provider.dart';
import 'package:esalonljepote_mobile/utils/util.dart';
import 'package:esalonljepote_mobile/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class KorisnikProfileScreen extends StatefulWidget {
  const KorisnikProfileScreen({Key? key}) : super(key: key);

  @override
  State<KorisnikProfileScreen> createState() => _KorisnikProfileScreen();
}

class _KorisnikProfileScreen extends State<KorisnikProfileScreen> {
  late KorisnikProvider _korisnikProvider;
  late UlogaProvider _ulogaProvider;
  List<Korisnik>? korisnikResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider = context.read<KorisnikProvider>();
    _ulogaProvider = context.read<UlogaProvider>();
    _fetchKorisnici();
  }

  Future<void> _fetchKorisnici() async {
    try {
      var data = await _korisnikProvider.get();
      setState(() {
        korisnikResult = data.result.where((korisnik) {
          return korisnik.korisnikUlogas.any((uloga) => uloga.ulogaId == 2);
        }).toList();
      });
    } catch (e) {
      print('Error fetching korisnici: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final korisnik = korisnikResult?.first;
    final screenWidth = MediaQuery.of(context).size.width;

    return MasterScreenWidget(
      title_widget: Text(
        "Hello, ${korisnik?.ime}! Welcome to your profile!",
        style: TextStyle(color: Colors.black),
      ),
      child: korisnik != null
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          screenWidth > 600
                              ? Row(
                                  children: [
                                    _buildProfilePicture(korisnik.slika),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${korisnik.ime ?? ''} ${korisnik.prezime ?? ''}",
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            korisnik.email ?? '',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[700]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    _buildProfilePicture(korisnik.slika),
                                    SizedBox(height: 16),
                                    Text(
                                      "${korisnik.ime ?? ''} ${korisnik.prezime ?? ''}",
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      korisnik.email ?? '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                          Divider(),
                          SizedBox(height: 16),
                          _buildProfileDetail(
                            "Username",
                            korisnik.korisnickoIme ?? '',
                            Icons.person,
                          ),
                          _buildProfileDetail(
                            "Date of birth",
                            korisnik.datumRodjenja ?? '',
                            Icons.cake,
                          ),
                          _buildProfileDetail(
                            "Phone number",
                            korisnik.telefon ?? '',
                            Icons.phone,
                          ),
                          _buildProfileDetail(
                            "Gender",
                            korisnik.spol ?? '',
                            Icons.person,
                          ),
                          SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _logout,
                            child: Text("Logout",
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  void _logout() {
    Authorization.korisnik = null;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  Widget _buildProfileDetail(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(12.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: Colors.blueAccent, size: 28),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$title:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        value,
                        style: TextStyle(fontSize: 16),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfilePicture(String? profilnaSlika) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.blueAccent,
      backgroundImage: profilnaSlika != null
          ? (profilnaSlika.startsWith('http')
              ? NetworkImage(profilnaSlika)
              : MemoryImage(base64Decode(profilnaSlika))) as ImageProvider
          : null,
      child: profilnaSlika == null
          ? Text(
              "N/A",
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
              ),
            )
          : null,
    );
  }
}