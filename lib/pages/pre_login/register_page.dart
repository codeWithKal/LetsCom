import 'package:flutter/material.dart';
import 'package:lets_com/pages/pre_login/HI_page/HI_regiseration.dart';
import 'package:lets_com/pages/pre_login/Voluteer_page/volunteer_registration.dart';


class MyOptionsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text('Registration')),
        body: Center(
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
                    MaterialPageRoute(builder: (context) => HRegistrationPage()),
                  );
                },
                child: Text('I\'m a hearing impaired person'),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VRegistrationPage()),
                  );
                },
                child: Text('I\'m here to Assist people'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
