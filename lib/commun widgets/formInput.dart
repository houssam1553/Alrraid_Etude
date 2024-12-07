import 'package:arraid/config/enums.dart';
import 'package:arraid/config/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class formInput extends StatelessWidget {
  formInput({
    super.key,
    required this.height,
    required this.label,
    required this.hint,
    this.textEditingController,
    required this.inputType,
    required this.obscureText,
    required this.togglePasswordVisibility,
    this.passwordController,
    this.options, // Add options for multiple-choice input
  });

  final String label;
  final String hint;
  final double height;
  final TextEditingController? textEditingController;
  final InputType inputType;
  final bool obscureText;
  final VoidCallback togglePasswordVisibility;
  final TextEditingController? passwordController;
  final List<String>? options;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        SizedBox(height: height * 0.008),
        inputType == InputType.multipleChoice
            ? DropdownButtonFormField<String>(
                items: options
                    ?.map((option) => DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        ))
                    .toList(),
                onChanged: (value) {
                  textEditingController?.text = value ?? '';
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: hint,
                  labelStyle: Theme.of(context).textTheme.labelMedium,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select an option";
                  }
                  return null;
                },
              )
            : TextFormField(
                controller: textEditingController,
                validator: (value) {
                  switch (inputType) {
                    case InputType.password:
                      return Validator.validatePassword(value);
                    case InputType.email:
                      return Validator.validateEmail(value);
                    case InputType.name:
                      return Validator.validateName(value);
                    case InputType.number:
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid number";
                      }
                      if (double.tryParse(value) == null) {
                        return "Only numeric values are allowed";
                      }
                      break;
                    case InputType.passwordCh:
                      return Validator.validatePassword(value);
                    case InputType.passwordChRepeat:
                      if (value != passwordController?.text) {
                        return "Passwords do not match";
                      }
                      break;
                    default:
                      return null;
                  }
                },
                obscureText: inputType == InputType.password ||
                        inputType == InputType.passwordCh ||
                        inputType == InputType.passwordChRepeat
                    ? obscureText
                    : false,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  labelText: hint,
                  labelStyle: Theme.of(context).textTheme.labelMedium,
                  suffixIcon: inputType == InputType.password
                      ? IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: togglePasswordVisibility,
                        )
                      : null,
                ),
                keyboardType: inputType == InputType.email
                    ? TextInputType.emailAddress
                    : inputType == InputType.number
                        ? TextInputType.number // Set numeric keyboard
                        : TextInputType.text,
              ),
      ],
    );
  }
}
