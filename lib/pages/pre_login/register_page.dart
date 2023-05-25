import 'package:flutter/material.dart';
import 'package:lets_com/pages/Services/sound_to_text.dart';
import 'package:lets_com/pages/pre_login/HI_page/HI_regiseration.dart';
import 'package:lets_com/pages/pre_login/Voluteer_page/volunteer_registration.dart';

import '../Services/text_to_speech.dart';

class MyOptionsPage extends StatefulWidget {
  @override
  State<MyOptionsPage> createState() => _MyOptionsPageState();
}

class _MyOptionsPageState extends State<MyOptionsPage> {
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Registration')),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tell us a little about yourself',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HRegistrationPage(),
                        ),
                      );
                    },
                    child: Text('I\'m a hearing impaired person'),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VRegistrationPage(),
                        ),
                      );
                    },
                    child: Text('I\'m here to assist people'),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16.0,
              bottom: 16.0,
              child: Column(
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
                      left: -120.0,
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

class ServicesMenu extends StatelessWidget {
  final double top;
  final double left;

  const ServicesMenu({
    required this.top,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
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
                  MaterialPageRoute(builder: (context) =>speech_to_text()),
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