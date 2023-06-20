import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HearingImpaired(),
    );
  }
}

class HearingImpaired extends StatefulWidget {
  @override
  _HearingImpairedState createState() => _HearingImpairedState();
}

class _HearingImpairedState extends State<HearingImpaired> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _streetNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePasswordController = TextEditingController();

  final CollectionReference _registrationRef =
  FirebaseFirestore.instance.collection('registrations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFormGroup(
              'Personal Information',
              [
                _buildTextField(_firstNameController, 'First Name'),
                _buildTextField(_lastNameController, 'Last Name'),
                _buildTextField(_phoneNumberController, 'Phone Number'),
                _buildTextField(_emailController, 'Email'),
              ],
            ),
            SizedBox(height: 16.0),
            _buildFormGroup(
              'Address',
              [
                _buildTextField(_nationalityController, 'Nationality'),
                _buildTextField(_countryController, 'Country'),
                _buildTextField(_stateController, 'State'),
                _buildTextField(_streetNumberController, 'Street Number'),
              ],
            ),
            SizedBox(height: 16.0),
            _buildCredentialsFormGroup(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Create a registration object from the form data
                Registration registration = Registration(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  phoneNumber: _phoneNumberController.text,
                  email: _emailController.text,
                  nationality: _nationalityController.text,
                  country: _countryController.text,
                  state: _stateController.text,
                  streetNumber: _streetNumberController.text,
                );

                // Store the registration data in Firebase Firestore
                _registrationRef.add(registration.toJson());

                // Reset the form
                _firstNameController.clear();
                _lastNameController.clear();
                _phoneNumberController.clear();
                _emailController.clear();
                _nationalityController.clear();
                _countryController.clear();
                _stateController.clear();
                _streetNumberController.clear();
                _passwordController.clear();
                _retypePasswordController.clear();
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormGroup(String label, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Card(
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCredentialsFormGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Credentials',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Card(
          elevation: 2.0,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(_passwordController, 'Password'),
                _buildTextField(_retypePasswordController, 'Retype Password'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      obscureText: label.contains('Password'),
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _nationalityController.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _streetNumberController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }
}

class Registration {
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String nationality;
  String country;
  String state;
  String streetNumber;

  Registration({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.nationality,
    required this.country,
    required this.state,
    required this.streetNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'nationality': nationality,
      'country': country,
      'state': state,
      'streetNumber': streetNumber,
    };
  }
}
