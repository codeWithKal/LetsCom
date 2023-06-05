import 'package:flutter/material.dart';
import 'package:lets_com/pages/Post_login/Assistant_pages/utils/textscale.dart';
import 'package:lets_com/pages/Post_login/Assistant_pages/routes/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: fixTextScale,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
    );
  }
}
