import 'package:arraid/commun%20widgets/customDialog.dart';
import 'package:arraid/config/exceptions.dart';
import 'package:arraid/models/userModel.dart';
import 'package:arraid/repositories/authRepository.dart';
import 'package:arraid/screens/HomeScreen/homeScreen.dart';
import 'package:arraid/services/localService.dart'; // Assuming you have this service for SharedPreferences
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;

  // Constructor
  LoginController(this.authRepository);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var obscurePassword = true.obs;
  RxBool rememberMe = false.obs;
  var isLoading = false.obs;

  // Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Validate and perform login
  Future<void> login() async {
    isLoading.value = true;
    LoadingDialog.showLoadingDialog(); // Show the loading dialog
    
    try {
      // Call the login API
      User user = await authRepository.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
print(rememberMe.value);
      // If login is successful, save credentials if "Remember Me" is selected
      if (rememberMe.value) {
        await LocalService.saveCredentials(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        await LocalService.saveRememberMe(true); // Save "Remember Me" status
      }else{
        await LocalService.saveRememberMe(false);
         await LocalService.clearCredentials();
      }

      // Handle successful login
      LoadingDialog.showResultIcon(true); // Show success icon
      await Future.delayed(Duration(seconds: 2)); // Show success animation
      LoadingDialog.closeDialog(); // Close dialog
      Get.to(() => Homescreen()); // Navigate to home screen

      // Clear text fields after successful login
      clearTextFields();
    } catch (e) {
      String errorMessage = 'An unexpected error occurred';  // Default error message
      int? statusCode;

      // Check if the exception contains a status code (like "404")
      if (e.toString().contains('404')) {
        statusCode = 404;
      } else if (e.toString().contains('401')) {
        statusCode = 401;
      } else if (e.toString().contains('500')) {
        statusCode = 500;
      } else if (e.toString().contains('SocketException')) {
        statusCode = 0;  // Handle network error
        errorMessage = 'No internet connection. Please check your network settings.';
      }

      // Customize the error message based on the status code
      if (statusCode != null) {
        switch (statusCode) {
          case 404:
            errorMessage = 'User not found\nPlease use a different email address or sign up';
            break;
          case 401:
            errorMessage = 'Please check your credentials';
            break;
          case 500:
            errorMessage = 'Internal server error\nPlease try again later.';
            break;
          default:
            errorMessage = 'An unexpected error occurred\n (Error $statusCode)';
        }
      }

      // Show the error icon with a custom error message
      LoadingDialog.showResultIcon(false, errorMessage: errorMessage);
      await Future.delayed(Duration(seconds: 3)); // Show error animation
      LoadingDialog.closeDialog(); // Close dialog
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }

  // Clear text fields after login or logout
  void clearTextFields() {
    emailController.clear();
    passwordController.clear();
  }



  // Method to check if "Remember Me" was selected and pre-fill credentials
  Future<void> checkRememberedCredentials() async {
    bool rememberMeStatus = await LocalService.getRememberMe();
    rememberMe.value = rememberMeStatus;

    if (rememberMeStatus) {
      var credentials = await LocalService.getCredentials();
      emailController.text = credentials['email'] ?? '';
      passwordController.text = credentials['password'] ?? '';

    }else{
      clearTextFields();
      await LocalService.clearCredentials();

    }
  }
}
