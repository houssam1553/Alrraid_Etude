import 'package:arraid/commun%20widgets/customDialog.dart';
import 'package:arraid/config/exceptions.dart';
import 'package:arraid/models/userModel.dart';
import 'package:arraid/repositories/authRepository.dart';
import 'package:arraid/screens/HomeScreen/homeScreen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
// Import the loading dialog

class LoginController extends GetxController {
  final AuthRepository authRepository;

  // Constructor
  LoginController(this.authRepository);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  var obscurePassword = true.obs;
  RxBool rememberMe = false.obs;
  var isLoading = false.obs;

  // Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Validate and perform login

 Future<void> login() async {
      if (loginFormKey.currentState!.validate()) {
      isLoading.value = true;
  LoadingDialog.showLoadingDialog();

  try {
    
    User user = await authRepository.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    // Handle successful login
    LoadingDialog.showResultIcon(true);
    await Future.delayed(Duration(seconds: 2)); // Show success animation
    LoadingDialog.closeDialog();
    Get.to(() => Homescreen());
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
    }

    // Customize the error message based on the status code
    if (statusCode != null) {
      switch (statusCode) {
        case 404:
          errorMessage = 'User not found';
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
    LoadingDialog.closeDialog();
  }
}
}

  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
