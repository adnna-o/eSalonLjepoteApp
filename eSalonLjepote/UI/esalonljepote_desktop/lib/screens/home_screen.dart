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
        color: Color(0xFFF1F8E9),
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gornji naslov
            Text(
              'Dobrodošli u eSalon Ljepote',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 172, 104, 142),
              ),
            ),
            SizedBox(height: 8),
            
            // Citat
            Text(
              'Beauty begins the moment you decide to be yourself.\n– Coco Chanel',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 172, 104, 142),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
