import 'package:flutter/material.dart';
import 'package:lets_com/pages/Services/sound_to_text.dart';
import 'package:lets_com/pages/pre_login/register_page.dart';

import '../Services/text_to_speech.dart';
import 'login_page.dart';

class LoginOrRegPage extends StatefulWidget {
  @override
  _LoginOrRegPageState createState() => _LoginOrRegPageState();
}

class _LoginOrRegPageState extends State<LoginOrRegPage> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome To LetsCom'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Letscom.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3), // Adjust the opacity as needed
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        'Login',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white.withOpacity(0.5),
                      onPrimary: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyOptionsPage()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      child: Text(
                        'Register for free',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white.withOpacity(0.5),
                      onPrimary: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _isMenuOpen = !_isMenuOpen;
              });
            },
            child: Icon(Icons.menu),
            tooltip: 'Services',
          ),
          if (_isMenuOpen)
            ServicesMenu(
              top: 0.0,
              right: -56.0,
            ),
        ],
      ),
    );
  }
}

class ServicesMenu extends StatelessWidget {
  final double top;
  final double right;

  const ServicesMenu({
    required this.top,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2), // changes the shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.mic),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => speech_to_text()),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.keyboard),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => text_to_speech()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
