import 'package:esalonljepote_desktop/models/korisnik.dart';
import 'package:esalonljepote_desktop/models/search_result.dart';
import 'package:esalonljepote_desktop/providers/korisnik_provider.dart';
import 'package:esalonljepote_desktop/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
 
class _WelcomeScreenState extends State<WelcomeScreen> {
  late KorisnikProvider _korisnikProvider;
  SearchResult<Korisnik>? _korisnik;

  @override
  void initState(){
    super.initState();


  }
  @override
   void didChangeDependencies() {
    super.didChangeDependencies();
    _korisnikProvider=context.read<KorisnikProvider>();
  }
 
 Future _fetchKorisnik() async{

 }
 
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF1F8E9),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text(
                  '“The best way to find yourself is to lose yourself in the service of others.\n – Mahatma Gandhi.\n It highlights the selflessness of organ donation."',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF1A237E),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 