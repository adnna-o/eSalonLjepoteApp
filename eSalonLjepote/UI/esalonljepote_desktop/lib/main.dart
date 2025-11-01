import 'package:esalonljepote_desktop/models/usluga.dart';
import 'package:esalonljepote_desktop/providers/administrator_provider.dart';
import 'package:esalonljepote_desktop/providers/galerija_provider.dart';
import 'package:esalonljepote_desktop/providers/klijenti_provider.dart';
import 'package:esalonljepote_desktop/providers/narudzba_provider.dart';
import 'package:esalonljepote_desktop/providers/novosti_provider.dart';
import 'package:esalonljepote_desktop/providers/placanje_provider.dart';
import 'package:esalonljepote_desktop/providers/proizvod_provider.dart';
import 'package:esalonljepote_desktop/providers/salonLjepote_provider.dart';
import 'package:esalonljepote_desktop/providers/termini_provider.dart';
import 'package:esalonljepote_desktop/providers/usluga_provider.dart';
import 'package:esalonljepote_desktop/providers/zaposleni_provider.dart';
import 'package:esalonljepote_desktop/screens/termin_screen.dart';
import 'package:esalonljepote_desktop/utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:esalonljepote_desktop/providers/korisnik_provider.dart';
import 'package:esalonljepote_desktop/providers/korisnik_uloga_provider.dart';
import 'package:esalonljepote_desktop/providers/uloga_provider.dart';
import 'package:esalonljepote_desktop/screens/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => KorisnikProvider()),
      ChangeNotifierProvider(create: (_) => UlogaProvider()),
      ChangeNotifierProvider(create: (_) => KorisnikUlogaProvider()),
      ChangeNotifierProvider(create: (_) => TerminiProvider()),
      ChangeNotifierProvider(create: (_) => KlijentiProvider()),
      ChangeNotifierProvider(create: (_) => ZaposleniProvider()),
      ChangeNotifierProvider(create: (_) => SalonLjepoteProvider()),
      ChangeNotifierProvider(create: (_) => UslugaProvider()),
      ChangeNotifierProvider(create: (_) => GalerijaProvider()),
      ChangeNotifierProvider(create: (_) => AdministratorProvider()),
      ChangeNotifierProvider(create: (_) => ProizvodProvider()),
      ChangeNotifierProvider(create: (_) => NovostiProvider()),
      ChangeNotifierProvider(create: (_) => NarudzbaProvider()),
      ChangeNotifierProvider(create: (_) => PlacanjeProvider()),
      
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
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
  int? loggedInUserID;
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
    setState(() {
      _isLoading = true;
    });
    var username = _usernameController.text;
    var password = _passwordController.text;
    Authorization.username = username;
    Authorization.password = password;
    try {
      Authorization.korisnik = await _korisnikProvider.Authenticate();
      if (Authorization.korisnik?.korisnikUlogas
              .any((role) => role.uloga?.nazivUloge == "Admin") ==
          true) {
        setState(() {
          loggedInUserID = Authorization.korisnik?.korisnikId;
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Text(
                "Vaš korisnički račun nema permisije za pristup admin panelu!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          ),
        );
      }
    } on Exception {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: Text("Pogrešno korisničko ime ili lozinka!"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("OK"))
                ],
              ));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _korisnikProvider = context.read<KorisnikProvider>();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.9,
              child: Image.asset(
                "assets/images/homepage.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child:Padding(padding: const EdgeInsets.only(bottom: 100),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 300, maxWidth: 400),
              child: Card(
                color: Color.fromARGB(255, 125, 111, 58).withOpacity(0.8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(height: 36,),
                      
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 173, 160, 117),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon:
                                Icon(Icons.account_circle, color: Colors.white),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                          ),
                          controller: _usernameController,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 173, 160, 117),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(color: Colors.white),
                            prefixIcon:
                                Icon(Icons.password, color: Colors.white),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                          ),
                          controller: _passwordController,
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      _isLoading
                          ? CircularProgressIndicator()
                          : SizedBox(
                              width: 400,
                              child: ElevatedButton(
                                onPressed: _login,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<
                                          Color>(
                                      Color.fromARGB(255, 173, 160, 117)),
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),],
      ),
    );
  }
}
