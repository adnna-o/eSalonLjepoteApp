import 'package:flutter/material.dart';
import 'package:esalonljepote_desktop/widget/master_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // 🖼️ Pozadinska slika
            Positioned.fill(
              child: Image.asset(
                'assets/images/homepage.png', // 👈 promijeni prema tvojoj slici
                fit: BoxFit.cover,
              ),
            ),

            // 🩶 Poluprozirni sloj preko slike (da tekst bude čitljiv)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.7),
              ),
            ),

            // ✨ Tekst u gornjem lijevom uglu
            Positioned(
             // top: 60,
              bottom: 60,
              right: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    '“Beauty begins the moment you decide to be yourself.”\n– Coco Chanel',
                    style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Color.fromRGBO(146, 126, 52, 1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
