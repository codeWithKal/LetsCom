import 'package:flutter/material.dart';

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
  TextEditingController _nationalityController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _streetNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _retypePasswordController = TextEditingController();

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
            _buildFormGroup(
              'Credential',
              [
                _buildPasswordField(_passwordController, 'Password'),
                _buildPasswordField(_retypePasswordController, 'Retype Password'),
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

  Widget _buildPasswordField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
      obscureText: true,
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
