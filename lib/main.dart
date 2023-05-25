import 'package:flutter/material.dart';
import 'package:lets_com/pages/pre_login/HI_page/HI_regiseration.dart';
import 'package:lets_com/pages/pre_login/Voluteer_page/volunteer_registration.dart';
import 'package:lets_com/pages/pre_login/login_page.dart';
import 'package:lets_com/pages/pre_login/reg_or_login_page.dart';
import 'package:lets_com/pages/pre_login/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginOrRegPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/registration': (context) => MyOptionsPage(),
        '/Hregistration': (context) => HRegistrationPage(),
        '/Vregistration': (context) => VRegistrationPage(),
      },
    );
  }
}
