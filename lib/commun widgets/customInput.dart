import 'package:flutter/material.dart';

class costumInput extends StatelessWidget {
  const costumInput({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30, // Adjusted height to ensure there's enough space for the cursor and text
      child: TextFormField(
        cursorHeight: 20,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            top: 3.0, // Added vertical padding to center text and cursor
            left: 25.0,
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