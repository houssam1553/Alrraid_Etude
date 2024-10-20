import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arraid/config/colors.dart'; // Ensure you have defined your color scheme here.

class Customsnackbar {
  static void show({
    required String title,
    required String message,
    Color? backgroundColor,
    Color? textColor,
    Duration? duration,
    IconData? icon,
  }) {
    // Close any existing snackbars before showing a new one
    Get.closeAllSnackbars();

    // Display the new snackbar
    Get.snackbar(
      title,
      message,
      //backgroundColor: backgroundColor ?? Colors.transparent, // Your custom color
     // colorText: textColor ?? Colors.white,
      icon: icon != null
          ? Icon(
              icon,
              color: Colors.white,
            )
          : null,
      snackPosition: SnackPosition.TOP, // Show at the bottom by default
   //   margin: const EdgeInsets.all(10),
     
      duration: duration ?? const Duration(seconds: 3),
      isDismissible: true,
      animationDuration: const Duration(milliseconds: 500),
    );
  }
}
