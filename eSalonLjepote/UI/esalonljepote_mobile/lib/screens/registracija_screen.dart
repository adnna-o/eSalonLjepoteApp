import 'package:esalonljepote_mobile/providers/korisnik_provider.dart';
import 'package:esalonljepote_mobile/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class RegistracijaScreen extends StatefulWidget {
  @override
  _RegistracijaScreenState createState() => _RegistracijaScreenState();
}

class _RegistracijaScreenState extends State<RegistracijaScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String ime = '';
  String prezime = '';
  String korisnickoIme = '';
  String email = '';
  String lozinka = '';
  String potvrdaLozinke = '';

  Future<void> _registrujSe() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final korisnikProvider =
          Provider.of<KorisnikProvider>(context, listen: false);
      final greska = await korisnikProvider.registruj(
        ime: ime,
        prezime: prezime,
        korisnickoIme: korisnickoIme,
        email: email,
        lozinka: lozinka,
      );

      setState(() {
        _isLoading = false;
      });

      if (greska == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registracija uspješna!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(greska)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        child: SafeArea(
          bottom: false,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 32),
              child: const Text(
                "Register on organ\ndonor app!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 54),
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 106, 20, 20)
                        .withOpacity(0.95),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 24),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(56),
                              child: Image.asset(
                                "assets/images/Organ4Life.jpg",
                                fit: BoxFit.contain,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            SizedBox(height: 30),
                            _buildInputField(
                              label: 'First name',
                              icon: Icons.person,
                              onChanged: (val) => ime = val,
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter first name' : null,
                            ),
                            SizedBox(height: 8),
                            _buildInputField(
                              label: 'Last name',
                              icon: Icons.person_outline,
                              onChanged: (val) => prezime = val,
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter last name' : null,
                            ),
                            SizedBox(height: 8),
                            _buildInputField(
                              label: 'Username',
                              icon: Icons.account_circle,
                              onChanged: (val) => korisnickoIme = val,
                              validator: (val) => val!.isEmpty
                                  ? 'Enter username'
                                  : null,
                            ),
                            SizedBox(height: 8),
                            _buildInputField(
                              label: 'Email',
                              icon: Icons.email,
                              onChanged: (val) => email = val,
                              validator: (val) =>
                                  val!.isNotEmpty && !val.contains('@')
                                      ? 'Incorrect email'
                                      : null,
                            ),
                            SizedBox(height: 8),
                            _buildInputField(
                              label: 'Password',
                              icon: Icons.lock,
                              obscureText: true,
                              onChanged: (val) => lozinka = val,
                              validator: (val) =>
                                  val!.length < 6 ? 'Min 6 karaktera' : null,
                            ),
                            SizedBox(height: 8),
                            _buildInputField(
                              label: 'Confirm password',
                              icon: Icons.lock_outline,
                              obscureText: true,
                              onChanged: (val) => potvrdaLozinke = val,
                              validator: (val) => val != lozinka
                                  ? 'Password doesn\t match.'
                                  : null,
                            ),
                            SizedBox(height: 30),
                            _isLoading
                                ? Center(child: CircularProgressIndicator())
                                : SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: _registrujSe,
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    255, 255, 255, 255)),
                                      ),
                                      child: Text(
                                        "Register",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.red),
                                      ),
                                    ),
                                  ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Sign in!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            )
          ]),
        ));
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required Function(String) onChanged,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: Icon(icon, color: Colors.black),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black54),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        ),
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}