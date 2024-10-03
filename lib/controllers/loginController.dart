import 'package:arraid/models/userModel.dart';
import 'package:arraid/repositories/authRepository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


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

      try {
        User user = await authRepository.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        // Handle successful login, navigate to home or dashboard
        Get.offAllNamed('/home');
      } catch (e) {
        Get.snackbar('Login Error', e.toString());
      } finally {
        isLoading.value = false;
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
