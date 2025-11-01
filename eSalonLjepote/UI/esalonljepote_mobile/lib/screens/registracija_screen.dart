import 'package:esalonljepote_mobile/providers/korisnik_provider.dart';
import 'package:esalonljepote_mobile/widget/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistracijaScreen extends StatefulWidget {
  const RegistracijaScreen({Key? key}) : super(key: key);

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
      setState(() => _isLoading = true);

      final korisnikProvider =
          Provider.of<KorisnikProvider>(context, listen: false);

      final greska = await korisnikProvider.registruj(
        ime: ime,
        prezime: prezime,
        korisnickoIme: korisnickoIme,
        email: email,
        lozinka: lozinka,
      );

      setState(() => _isLoading = false);

      if (greska == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registracija uspješna!')),
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
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            // Gradient pozadina
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE3A6B2), Color(0xFFFAE5E9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            // Scrollable sadržaj
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 450,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(56),
                            child: Image.asset(
                              "assets/images/stuff.png",
                              fit: BoxFit.contain,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          const SizedBox(height: 30),
                          _buildInputField(
                            label: 'First name',
                            icon: Icons.person,
                            onChanged: (val) => ime = val,
                            validator: (val) =>
                                val!.isEmpty ? 'Enter first name' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildInputField(
                            label: 'Last name',
                            icon: Icons.person_outline,
                            onChanged: (val) => prezime = val,
                            validator: (val) =>
                                val!.isEmpty ? 'Enter last name' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildInputField(
                            label: 'Username',
                            icon: Icons.account_circle,
                            onChanged: (val) => korisnickoIme = val,
                            validator: (val) =>
                                val!.isEmpty ? 'Enter username' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildInputField(
                            label: 'Email',
                            icon: Icons.email,
                            onChanged: (val) => email = val,
                            validator: (val) => val!.isNotEmpty &&
                                    !val.contains('@')
                                ? 'Incorrect email'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          _buildInputField(
                            label: 'Password',
                            icon: Icons.lock,
                            obscureText: true,
                            onChanged: (val) => lozinka = val,
                            validator: (val) =>
                                val!.length < 6 ? 'Min 6 characters' : null,
                          ),
                          const SizedBox(height: 12),
                          _buildInputField(
                            label: 'Confirm password',
                            icon: Icons.lock_outline,
                            obscureText: true,
                            onChanged: (val) => potvrdaLozinke = val,
                            validator: (val) =>
                                val != lozinka ? 'Password doesn\'t match' : null,
                          ),
                          const SizedBox(height: 30),
                          _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.pinkAccent,
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _registrujSe,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pinkAccent,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      elevation: 4,
                                    ),
                                    child: const Text(
                                      "Register",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 20),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(fontSize: 15),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Text(
                                  "Sign in!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pinkAccent,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required Function(String) onChanged,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black87),
        prefixIcon: Icon(icon, color: Colors.black87),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
