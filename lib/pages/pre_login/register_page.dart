import 'package:flutter/material.dart';
import 'package:lets_com/pages/Services/sound_to_text.dart';
import 'package:lets_com/pages/Services/text_to_speech.dart';
import 'package:lets_com/pages/pre_login/HI_page/HI_regiseration.dart';
import 'package:lets_com/pages/pre_login/Voluteer_page/volunteer_registration.dart';

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
        // appBar: AppBar(title: Text('Registration')),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Letscom.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tell us a little about yourself',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HRegistrationPage()),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              "I'm a hearing impaired person",
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
                              MaterialPageRoute(builder: (context) => VRegistrationPage()),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              "I'm here to assist people",
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
              ),
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _isMenuOpen = !_isMenuOpen;
                  });
                },
                child: Icon(Icons.menu),
                tooltip: 'Services',
                backgroundColor: Colors.black.withOpacity(0.5),
              ),
            ),
            if (_isMenuOpen)
              Positioned(
                bottom: 56.0,
                right: 76.0,
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(-2, 0), // Changes the shadow position
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
              ),
          ],
        ),
      ),
    );
  }
}
