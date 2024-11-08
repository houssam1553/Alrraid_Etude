import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';

class SocialMediaBox extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;

  const SocialMediaBox({
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen size inside the build method
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width * 0.18,  // Example: set width to 30% of screen width
        height: width * 0.18,  // Set height of the box
        decoration: BoxDecoration(
          // Background color for the box
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFE2E8F0), // Border color
            width: 1.5, // Border width
          ), // Rounded corners
        ),
        child: Center(
          child: Icon(
            icon,
            color: ColorManager.TextColor, // Icon color
            size: 30, // Icon size
          ),
        ),
      ),
    );
  }
}
