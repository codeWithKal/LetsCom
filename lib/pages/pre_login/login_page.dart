import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_com/pages/Post_login/Assistant_pages/screens/home.dart';
import 'package:lets_com/pages/Post_login/HI_pages/screens/home.dart';
import 'package:lets_com/pages/pre_login/register_page.dart';
import 'Assisant_page/Assistant_registration.dart';
import 'HI_page/HI_regiseration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> validateUser(String email, String password) async {
    final usersCollection = FirebaseFirestore.instance.collection('users');
    final snapshot = await usersCollection.where('email', isEqualTo: email).where('password', isEqualTo: password).get();

    return snapshot.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Letscom.png'), // Replace with your image path
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken), // Add this line to darken the background
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 100, 0, 30),
          child: Align(
            alignment: Alignment.center,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LetsCom, your assistance!",
                    style: TextStyle(color: Colors.white),
                  ),
                  TabBar(
                    controller: _tabController,
                    tabs: [
                      Tab(text: 'HI Login'),
                      Tab(text: 'Assistant Login'),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        buildHITab(),
                        buildAssistantLoginTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHITab() {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: () async {
            final email = _emailController.text;
            final password = _passwordController.text;

            if (await validateUser(email, password)) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HHome()),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Login Failed'),
                    content: Text('Invalid email or password.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Login', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue, // Example button color
          ),
        ),
        SizedBox(height: 16.0),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Don\'t have an account? ',
            style: TextStyle(
              color: Colors.grey,
            ),
            children: [
              TextSpan(
                text: 'Register',
                style: TextStyle(
                  color: Colors.white,
                ),
                // Add register button press handler here
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HearingImpaired()),
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAssistantLoginTab() {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: () async {
            final email = _emailController.text;
            final password = _passwordController.text;

            if (await validateUser(email, password)) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AHome()),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Login Failed'),
                    content: Text('Invalid email or password.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Login', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue, // Example button color
          ),
        ),
        SizedBox(height: 16.0),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Don\'t have an account? ',
            style: TextStyle(
              color: Colors.grey,
            ),
            children: [
              TextSpan(
                text: 'Register',
                style: TextStyle(
                  color: Colors.white,
                ),
                // Add register button press handler here
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Assistant()),
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
