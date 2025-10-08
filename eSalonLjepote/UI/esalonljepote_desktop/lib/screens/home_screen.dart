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
            // Gornji naslov i slogan
            Text(
              'Dobrodošli u eSalon Ljepote',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 172, 104, 142),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Beauty begins the moment you decide to be yourself.\n– Coco Chanel',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 172, 104, 142),
              ),
            ),

            SizedBox(height: 32),

            // Glavni meni sa karticama (grid)
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                children: [
                  _buildMenuCard(
                    context,
                    title: 'Zaposleni',
                    icon: Icons.people,
                    color: Colors.pinkAccent,
                    onTap: () {
                      // Navigiraj na screen za zaposlene
                      Navigator.pushNamed(context, '/zaposleni');
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Klijenti',
                    icon: Icons.person,
                    color: Colors.teal,
                    onTap: () {
                      Navigator.pushNamed(context, '/klijenti');
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Narudžbe',
                    icon: Icons.shopping_cart,
                    color: Colors.deepPurple,
                    onTap: () {
                      Navigator.pushNamed(context, '/narudzbe');
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Usluge',
                    icon: Icons.spa,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pushNamed(context, '/usluge');
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Proizvodi',
                    icon: Icons.production_quantity_limits,
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.pushNamed(context, '/proizvodi');
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Termini',
                    icon: Icons.calendar_today,
                    color: Colors.green,
                    onTap: () {
                      Navigator.pushNamed(context, '/termini');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context,
      {required String title,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
