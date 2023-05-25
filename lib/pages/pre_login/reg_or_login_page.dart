import 'package:flutter/material.dart';
import 'package:lets_com/pages/pre_login/register_page.dart';

import 'login_page.dart';

class LoginOrRegPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login or Registration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyOptionsPage()),
                );
              },
              child: Text('Registration'),
            ),
          ],
        ),
      ),
    );
  }
}
