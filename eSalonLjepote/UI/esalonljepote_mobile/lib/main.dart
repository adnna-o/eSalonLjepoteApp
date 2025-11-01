import 'package:esalonljepote_mobile/providers/cart_provider.dart';
import 'package:esalonljepote_mobile/providers/galerija_provider.dart';
import 'package:esalonljepote_mobile/providers/klijenti_provider.dart';
import 'package:esalonljepote_mobile/providers/korisnik_provider.dart';
import 'package:esalonljepote_mobile/providers/korisnik_uloga_provider.dart';
import 'package:esalonljepote_mobile/providers/narudzba_provider.dart';
import 'package:esalonljepote_mobile/providers/novosti_provider.dart';
import 'package:esalonljepote_mobile/providers/ocjene_proizvoda_provider.dart';
import 'package:esalonljepote_mobile/providers/proizvod_provider.dart';
import 'package:esalonljepote_mobile/providers/recenzije_provider.dart';
import 'package:esalonljepote_mobile/providers/salonLjepote_provider.dart';
import 'package:esalonljepote_mobile/providers/termini_provider.dart';
import 'package:esalonljepote_mobile/providers/uloga_provider.dart';
import 'package:esalonljepote_mobile/providers/usluga_provider.dart';
import 'package:esalonljepote_mobile/providers/zaposleni_provider.dart';
import 'package:esalonljepote_mobile/screens/home_screen.dart';
import 'package:esalonljepote_mobile/screens/registracija_screen.dart';
import 'package:esalonljepote_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => KorisnikProvider()),
      ChangeNotifierProvider(create: (_) => UlogaProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikUlogaProvider()),
      ChangeNotifierProvider(create: (_) => SalonLjepoteProvider()),
      ChangeNotifierProvider(create: (_) => UslugaProvider()),
      ChangeNotifierProvider(create: (_) => ProizvodProvider()),
      ChangeNotifierProvider(create: (_) => NovostiProvider()),
      ChangeNotifierProvider(create: (_) => NarudzbaProvider()),
      ChangeNotifierProvider(create: (_) => ZaposleniProvider()),
      ChangeNotifierProvider(create: (_) => KlijentiProvider()),
      ChangeNotifierProvider(create: (_) => TerminiProvider()),
      ChangeNotifierProvider(create: (_) => RecenzijaProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => OcjeneProizvodaProvider()),
      ChangeNotifierProvider(create: (_) => GalerijaProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eSalon Ljepote',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const LoginPage(),
      routes: {
        '/register': (context) => RegistracijaScreen(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late KorisnikProvider _korisnikProvider;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);

    Authorization.username = _usernameController.text;
    Authorization.password = _passwordController.text;

    try {
      Authorization.korisnik = await _korisnikProvider.Authenticate();

      if (Authorization.korisnik?.korisnikUlogas
              .any((role) => role.uloga?.nazivUloge == "Korisnik") ==
          true) {
        Authorization.userId = Authorization.korisnik?.korisnikId;
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        _showMessage(
            "Vaš korisnički račun nema dozvolu za pristup korisničkom panelu!");
      }
    } on Exception {
      _showMessage("Pogrešno korisničko ime ili lozinka!");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showMessage(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Text(message,
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text("OK",
                        style: TextStyle(color: Colors.pinkAccent)))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    _korisnikProvider = context.read<KorisnikProvider>();

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

            // Glavni sadržaj scrollable
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.spa,
                            color: Colors.pinkAccent, size: 80),
                        const SizedBox(height: 16),
                        const Text(
                          "Dobrodošli u eSalon Ljepote",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),

                        // Username
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: "Korisničko ime",
                            prefixIcon: const Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Password
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Lozinka",
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),

                        // Login button
                        _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.pinkAccent,
                              )
                            : ElevatedButton(
                                onPressed: _login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pinkAccent,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 80),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 4,
                                ),
                                child: const Text(
                                  "Prijava",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),

                        const SizedBox(height: 20),

                        // Register link
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text(
                              "Nemate račun? ",
                              style: TextStyle(fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).pushNamed('/register'),
                              child: const Text(
                                "Registrujte se!",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pinkAccent,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
}
