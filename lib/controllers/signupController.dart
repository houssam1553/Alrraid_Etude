import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/models/userModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:arraid/repositories/authRepository.dart';
import 'package:arraid/commun%20widgets/customDialog.dart'; // Import your custom dialog

class SignupController extends GetxController {
  final AuthRepository authRepository;

  SignupController(this.authRepository);
  final navigationController = Get.find<NavigationController>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  var obscurePassword = true.obs;
  var isLoading = false.obs; // Loading state for the signup process

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> signUp() async {
    if (signupFormKey.currentState?.validate() ?? false) {
      isLoading.value = true; // Set loading state to true
      LoadingDialog.showLoadingDialog(); // Show loading dialog

      try {
        // Call the signUp method in AuthRepository
        User newUser = await authRepository.signUp(
          emailController.text.trim(),
          passwordController.text.trim(),
          firstNameController.text.trim(),
          lastNameController.text.trim(),
        );

        // Handle successful signup
        LoadingDialog.showResultIcon(true); // Show success icon
        await Future.delayed(
            Duration(seconds: 2)); // Wait for a moment to show the success icon
        LoadingDialog.closeDialog();
        navigationController.goToCodetab(); // Close the dialog
        // Update with your actual home route
      } catch (e) {
        String errorMessage =
            'An unexpected error occurred'; // Default error message
        int? statusCode;

        // Check if the exception contains a status code
        if (e.toString().contains('400')) {
          statusCode = 400;
        } else if (e.toString().contains('409')) {
          statusCode = 409; // Conflict (e.g., email already exists)
        } else if (e.toString().contains('500')) {
          statusCode = 500; // Internal Server Error
        }

        // Customize the error message based on the status code
        switch (statusCode) {
          case 400:
            errorMessage = 'Please fill all your inputs.';
            break;
          case 409:
            errorMessage = 'Email already exists\nPlease try another one.';
            break;
          case 500:
            errorMessage = 'Internal server error. Please try again later.';
            break;
          default:
            errorMessage = 'An unexpected error occurred. (Error $statusCode)';
        }

        // Show the error icon with a custom error message
        LoadingDialog.showResultIcon(false, errorMessage: errorMessage);
        await Future.delayed(Duration(seconds: 3)); // Show error animation
        LoadingDialog.closeDialog(); // Close the dialog
      } finally {
        isLoading.value = false; // Reset loading state
      }
    }
  }

  @override
  void onClose() {
    // Dispose of controllers when the SignupController is closed
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }

/*   void clearTextFields() {
    emailController.clear();
    passwordController.clear();
     firstNameController.clear();
    lastNameController.clear();
  } */
}
