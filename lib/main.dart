import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lets_com/pages/Post_login/HI_pages/screens/appointment.dart';
import 'package:lets_com/pages/Services/speech_to_text.dart';
import 'package:lets_com/pages/Services/text_to_speech.dart';
import 'package:lets_com/pages/pre_login/Assisant_page/Assistant_registration.dart';
import 'package:lets_com/pages/pre_login/HI_page/HI_regiseration.dart';
import 'package:lets_com/pages/pre_login/login_page.dart';
import 'package:lets_com/pages/pre_login/reg_or_login_page.dart';
import 'package:lets_com/pages/pre_login/register_page.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/Hregistration': (context) => HearingImpaired(),
        '/Vregistration': (context) => Assistant(),
      },
    );
  }
}

