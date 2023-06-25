import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_com/pages/pre_login/successfull_login.dart';
import 'package:country_picker/country_picker.dart';

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
  TextEditingController _countryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePasswordController = TextEditingController();

  final CollectionReference _registrationRef =
  FirebaseFirestore.instance.collection('Hearing Impaired People');

  bool _isSubmitted = false;

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
                _buildTextField(_countryController, 'Country'),
                _buildTextField(_cityController, 'City'),
              ],
            ),
            SizedBox(height: 16.0),
            _buildCredentialsFormGroup(),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isSubmitted = true;
                });

                if (_validateForm()) {
                  // Create a registration object from the form data
                  Registration registration = Registration(
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    phoneNumber: _phoneNumberController.text,
                    email: _emailController.text,
                    country: _countryController.text,
                    city: _cityController.text,
                  );

                  // Store the registration data in Firebase Firestore
                  _registrationRef.add(registration.toJson());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationSuccessPage(),
                    ),
                  );
                }
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
                SizedBox(height: 8.0),
                _buildTextField(_retypePasswordController, 'Retype Password'),
                _isSubmitted &&
                    _validateField(
                        _retypePasswordController.text, 'Retype Password') &&
                    _passwordController.text.isNotEmpty
                    ? Text(
                  'Passwords do not match',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )
                    : Container(),
                SizedBox(height: 8.0),
                Text(
                  'Passwords must contain at least one character, one number, and one special symbol',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
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
      readOnly: label == 'Country',
      onTap: () {
        if (label == 'Country') {
          showCountryPicker(
            context: context,
            showPhoneCode: false,
            onSelect: (country) {
              setState(() {
                _countryController.text = country.name;
              });
            },
          );
        }
      },
      obscureText: label.contains('Password'),
      decoration: InputDecoration(
        labelText: label,
        errorText: _isSubmitted && _validateField(controller.text, label)
            ? _getErrorText(controller.text, label)
            : null,
      ),
    );
  }

  bool _validateField(String value, String label) {
    if (label == 'First Name' || label == 'Last Name') {
      return !RegExp(r'^[a-zA-Z]+$').hasMatch(value);
    } else if (label == 'Phone Number') {
      return !RegExp(r'^[0-9]{10}$').hasMatch(value);
    } else if (label == 'Email') {
      return !RegExp(
          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
          .hasMatch(value);
    } else if (label == 'Password' || label == 'Retype Password') {
      return !RegExp(
          r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])')
          .hasMatch(value);
    }
    return false;
  }

  String _getErrorText(String value, String label) {
    if (label == 'First Name' || label == 'Last Name') {
      return 'Please use characters only';
    } else if (label == 'Phone Number') {
      return 'Please enter a valid phone number';
    } else if (label == 'Email') {
      return 'Please enter a valid email address';
    } else if (label == 'Password') {
      if (!_validateField(value, label)) {
        return 'Please enter a valid password with at least one letter, one number, and one special character';
      }
    }
    return '';
  }

  bool _validateForm() {
    bool isValid = true;
    List<Map<String, dynamic>> formFields = [
      {'value': _firstNameController.text, 'label': 'First Name'},
      {'value': _lastNameController.text, 'label': 'Last Name'},
      {'value': _phoneNumberController.text, 'label': 'Phone Number'},
      {'value': _emailController.text, 'label': 'Email'},
      {'value': _countryController.text, 'label': 'Country'},
      {'value': _cityController.text, 'label': 'City'},
      {'value': _passwordController.text, 'label': 'Password'},
      {'value': _retypePasswordController.text, 'label': 'Retype Password'},
    ];

    for (Map<String, dynamic> field in formFields) {
      if (_validateField(field['value'], field['label'])) {
        isValid = false;
      }
    }

    return isValid;
  }
}

class Registration {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String country;
  final String city;

  Registration({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.country,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'country': country,
      'city': city,
    };
  }
}
