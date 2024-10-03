import 'package:arraid/models/userModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:arraid/repositories/authRepository.dart';


class SignupController extends GetxController {
  final AuthRepository authRepository;

  SignupController(this.authRepository);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  var obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> signUp() async {
    if (signupFormKey.currentState?.validate() ?? false) {
      try {
        // Call the signUp method in AuthRepository
        User newUser = await authRepository.signUp(
          emailController.text.trim(),
          passwordController.text.trim(),
          firstNameController.text.trim(),
          lastNameController.text.trim(),
        );

        // Handle successful signup (e.g., navigate to another screen)
        Get.offAllNamed('/home'); // Update with your actual home route
      } catch (e) {
        // Handle signup error (e.g., show a snackbar)
        Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
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
}
