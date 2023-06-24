import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';

import '../successfull_login.dart';

class Assistant extends StatefulWidget {
  @override
  _AssistantState createState() => _AssistantState();
}

class _AssistantState extends State<Assistant> {
  String _selectedPreference = '';
  String _selectedFee = '';
  String _selectedHourlyRate = '';
  bool _showHourlyRateSection = false; // Track whether to show the hourly rate section or not

  List<String> _preferences = ['Individual', 'Group', 'Both'];
  List<String> _fees = ["I'm volunteer", "I'm freelancing"];
  List<String> _hourlyRates = [
    '1-100 ETB/hour',
    '100-200 ETB/hour',
    '>200 ETB/hour',
  ];

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePasswordController = TextEditingController();

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
                _buildTextField(_firstNameController, 'First Name', 'Enter a valid first name', validateFirstName),
                _buildTextField(_lastNameController, 'Last Name', 'Enter a valid last name', validateLastName),
                _buildTextField(_phoneNumberController, 'Phone Number', 'Enter a valid phone number', validatePhoneNumber),
                _buildTextField(_emailController, 'Email', 'Enter a valid email', validateEmail),
              ],
            ),
            SizedBox(height: 16.0),
            _buildFormGroup(
              'Address',
              [
                _buildCountryPickerField(_countryController, 'Country'),
                _buildTextField(_stateController, 'City', 'Enter a valid city', validateCity),
              ],
            ),
            SizedBox(height: 16.0),
            _buildFormGroup(
              'Credential',
              [
                _buildPasswordField(_passwordController, 'Password', 'Enter a valid password', validatePassword),
                _buildPasswordField(_retypePasswordController, 'Retype Password', 'Passwords do not match', validateRetypePassword),
              ],
            ),
            SizedBox(height: 16.0),
            _buildFormGroup(
              'Preference',
              _buildRadioButtons(_preferences, (value) {
                setState(() {
                  _selectedPreference = value;
                });
              }, 'preference'),
            ),
            SizedBox(height: 16.0),
            _buildFormGroup(
              'Fee',
              _buildRadioButtons(_fees, (value) {
                setState(() {
                  _selectedFee = value;
                  _showHourlyRateSection = value == "I'm freelancing";
                });
              }, 'fee'),
            ),
            if (_showHourlyRateSection) ...[
              SizedBox(height: 16.0),
              _buildFormGroup(
                'Hourly Rate',
                _buildRadioButtons(_hourlyRates, (value) {
                  setState(() {
                    _selectedHourlyRate = value;
                  });
                }, 'hourly_rate'),
              ),
            ],
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _validateFields,
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

  Widget _buildTextField(
      TextEditingController controller, String label, String errorText, Function(String) validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        errorText: _isSubmitted && !validator(controller.text) ? errorText : null,
      ),
    );
  }

  Widget _buildPasswordField(
      TextEditingController controller, String label, String errorText, Function(String) validator) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        errorText: _isSubmitted && !validator(controller.text) ? errorText : null,
      ),
      obscureText: true,
    );
  }

  Widget _buildCountryPickerField(
      TextEditingController controller, String label) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          onSelect: (Country country) {
            setState(() {
              controller.text = country.name;
            });
          },
        );
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRadioButtons(
      List<String> options, void Function(String) onChanged, String groupValue) {
    return options.map((option) {
      return Row(
        children: [
          Radio<String>(
            value: option,
            groupValue: _getGroupValue(groupValue),
            onChanged: (String? value) {
              onChanged(value!);
            },
          ),
          Text(option),
        ],
      );
    }).toList();
  }

  String _getGroupValue(String groupValue) {
    if (groupValue == 'preference') {
      return _selectedPreference;
    } else if (groupValue == 'fee') {
      return _selectedFee;
    } else if (groupValue == 'hourly_rate') {
      return _selectedHourlyRate;
    }
    return '';
  }

  void _validateFields() {
    setState(() {
      _isSubmitted = true;
    });

    if (!_isFormValid()) {
      return; // Return if any of the fields are invalid
    }

    // Store the user data in Firestore or perform any other necessary actions
    // Here, you can navigate to the next screen or show a success message
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationSuccessPage()),
    );
  }

  bool _isFormValid() {
    return validateFirstName(_firstNameController.text) &&
        validateLastName(_lastNameController.text) &&
        validatePhoneNumber(_phoneNumberController.text) &&
        validateEmail(_emailController.text) &&
        validateCity(_stateController.text) &&
        validatePassword(_passwordController.text) &&
        validateRetypePassword(_retypePasswordController.text);
  }

  bool validateFirstName(String firstName) {
    return firstName.isNotEmpty;
  }

  bool validateLastName(String lastName) {
    return lastName.isNotEmpty;
  }

  bool validatePhoneNumber(String phoneNumber) {
    return phoneNumber.isNotEmpty;
  }

  bool validateEmail(String email) {
    return email.isNotEmpty && email.contains('@');
  }

  bool validateCity(String city) {
    return city.isNotEmpty;
  }

  bool validatePassword(String password) {
    return password.isNotEmpty && password.length >= 6;
  }

  bool validateRetypePassword(String retypePassword) {
    return retypePassword.isNotEmpty && retypePassword == _passwordController.text;
  }
}
