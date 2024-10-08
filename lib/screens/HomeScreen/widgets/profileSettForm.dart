import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/enums.dart';
import 'package:flutter/material.dart';

class ProfileSettingsForm extends StatefulWidget {
  const ProfileSettingsForm({
    super.key,
    required this.height,
    required this.width,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
  final String firstName;
  final String lastName;
  final String email;
  final double height;
  final double width;

  @override
  _ProfileSettingsFormState createState() => _ProfileSettingsFormState();
}

class _ProfileSettingsFormState extends State<ProfileSettingsForm> {
  final _formKey = GlobalKey<FormState>(); // Key to identify the form
  String name = '';
  String email = '';
  String phone = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Assign the form key
      child: Column(
        children: [
          SizedBox(height: widget.height * 0.0210),
          formInput(
              height: widget.height,
              label: 'First Name',
              hint: widget.firstName,
              inputType: InputType.name,
              obscureText: false,
              togglePasswordVisibility: () {}),
          SizedBox(height: widget.height * 0.0210),
          formInput(
              height: widget.height,
              label: 'Last Name',
              hint: widget.lastName,
              inputType: InputType.name,
              obscureText: false,
              togglePasswordVisibility: () {}),
          SizedBox(height: widget.height * 0.0210),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          SizedBox(height: widget.height * 0.008),
          TextFormField(
            onChanged: (value) {
              email = value; // Update the email state variable
            },
           enabled: false,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              labelText: widget.email,
              labelStyle: Theme.of(context).textTheme.labelMedium,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: widget.height * 0.04),
          SizedBox(
            height: widget.height * 0.0557,
            width: widget.width * 0.823,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, proceed with the desired action
                  // For example, you can call a function to save changes
                  print('Name: $name');
                  print('Email: $email');
                  print('Phone: $phone');
                  print('Address: $address');
                }
              },
              child: Text(
                "Apply changes",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                    ),
              ),
            ),
          ),
          SizedBox(height: widget.height * 0.0357),
        ],
      ),
    );
  }
}
