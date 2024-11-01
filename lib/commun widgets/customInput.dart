import 'package:flutter/material.dart';

class costumInput extends StatelessWidget {
  const costumInput({
    super.key,
    required this.label, required this.isEnabeled, required this.controller,
  });
final bool isEnabeled;
  final String label;
 final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30, // Adjusted height to ensure there's enough space for the cursor and text
      child: TextFormField(
        controller: controller,
        enabled: isEnabeled,
        cursorHeight: 20,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 3.0, // Added vertical padding to center text and cursor
            left: 25.0,
            right: 10
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          prefixIcon: null,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.labelMedium,
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}