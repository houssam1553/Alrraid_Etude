import 'package:arraid/controllers/loginController.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/controllers/signupController.dart';
import 'package:arraid/controllers/verificationController.dart';
import 'package:arraid/repositories/authRepository.dart';
import 'package:arraid/services/apiService.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Register the ApiService
    Get.lazyPut<ApiService>(() => ApiService('https://api.example.com'));

    // Register the AuthRepository
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find<ApiService>()));

    // Register the LoginController
    Get.lazyPut<LoginController>(() => LoginController(Get.find<AuthRepository>()));

    // Register the SignupController
  
    Get.lazyPut<SignupController>(() => SignupController(Get.find<AuthRepository>()));
  Get.lazyPut<VerificationController>(() => VerificationController( Get.find<AuthRepository>())); 
    // Register the NavigationController
    Get.lazyPut<NavigationController>(() => NavigationController());
  }
}

class SignupBindings extends Bindings {
  @override
  void dependencies() {
    // Register the SignupController
    Get.lazyPut<SignupController>(() => SignupController(Get.find<AuthRepository>()));
    
    // Register the VerificationController
    Get.lazyPut<VerificationController>(() => VerificationController( Get.find<AuthRepository>()));
  }
}