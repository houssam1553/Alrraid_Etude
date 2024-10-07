import 'package:arraid/commun%20widgets/customDialog.dart';
import 'package:arraid/config/exceptions.dart';
import 'package:arraid/repositories/authRepository.dart';
import 'package:arraid/services/localService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  final AuthRepository authRepository;
  final TextEditingController codeController = TextEditingController();
  var isLoading = false.obs;
  var isValide = false.obs;



  VerificationController( this.authRepository);

  Future<void> verifyCode() async {
    isLoading.value = true;
    
    LoadingDialog.showLoadingDialog();

    // Fetch the token
    String? token = await LocalService.getToken();

    // Check if the token is null
    if (token == null) {
      // Handle the case where the token is missing (e.g., navigate to login)
     /*  LoadingDialog.showResultIcon(false,errorMessage: "Unvalid token",);
      await Future.delayed(Duration(seconds: 2)); 
      LoadingDialog.closeDialog();


     // Get.offAllNamed('/login'); // Adjust this to your login route
      return; */
      token = "token";
    }
    

    try {
      print("token  "+  token);
      // Call the AuthRepository to verify the code
      await authRepository.verifyCode(
        codeController.text.trim(),
        token, // Now token is guaranteed to be non-null
      );
      

      // Success - show success icon and navigate to home screen
      LoadingDialog.showResultIcon(true);
      await Future.delayed(Duration(seconds: 2));
      LoadingDialog.closeDialog();
       isValide.value= true ;
      
      // Perform any additional navigation or logic
     // Get.offAllNamed('/home'); // Uncomment this line to navigate to home
    } catch (e) {
      // Handle errors from AuthRepository
     String errorMessage = 'An unexpected error occurred'; // Default error message
        int? statusCode;

        // Check if the exception contains a status code
        if (e.toString().contains('401')) {
          statusCode = 401;
        } else if (e.toString().contains('409')) {
          statusCode = 409; // Conflict (e.g., email already exists)
        } else if (e.toString().contains('500')) {
          statusCode = 500; // Internal Server Error
        }

        // Customize the error message based on the status code
        switch (statusCode) {
          case 401:
            errorMessage = 'Please check your code';
            isValide.value = false ;
            break;
          case 409:
            errorMessage = 'Email already exists. Please try another one.';
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

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}
