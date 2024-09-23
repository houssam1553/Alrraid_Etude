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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80, // Set width of the box
        height: 80, // Set height of the box
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