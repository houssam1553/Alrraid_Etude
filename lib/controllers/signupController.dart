
import 'package:get/get.dart';
import 'package:flutter/material.dart';


class Signupcontroller extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();




  var obscurePassword = true.obs;
  RxBool rememberMe = false.obs;

 /*  @override
  void onInit() {
    super.onInit();
    
    // Retrieve and print stored values
  
    
    
   /*  String? savedEmail = localStorage.read("Remember_Email");
    String? savedPassword = localStorage.read("Remember_Password");
    
    emailController.text = savedEmail ?? ''; // Provide default empty string if null
    passwordController.text = savedPassword ?? '';  
  }*/ */

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  
}
