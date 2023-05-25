import 'package:flutter/material.dart';

class HRegistrationPage extends StatefulWidget {

  @override
  _HRegistrationPageState createState() => _HRegistrationPageState();
}

class _HRegistrationPageState extends State<HRegistrationPage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _streetNumberController = TextEditingController();

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
            ElevatedButton(
              onPressed: () {
                // Perform registration logic here
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

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
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
    super.dispose();
  }
}
