import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  // State variable to manage button text
  String buttonText = "Yes";
  Color buttonColor = ColorManager.primary; // Initial button color

  void _onPressed() {
    setState(() {
      // Change button text and color when pressed
      buttonText = buttonText == "Yes" ? "No" : "Yes"; // Toggle text
      buttonColor = buttonColor == ColorManager.primary? Color(0xFFCBD5E0) : ColorManager.primary; // Toggle color
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          onPressed: _onPressed,
          child: Text(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor, // Set the button background color
          ),
        
      
    );
  }
}
