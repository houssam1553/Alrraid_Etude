import 'package:arraid/controllers/homeNavigationCtrl.dart';
import 'package:arraid/controllers/loginController.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/controllers/profileSettingsController.dart';
import 'package:arraid/controllers/signupController.dart';
import 'package:arraid/controllers/teamController.dart';
import 'package:arraid/controllers/usersController.dart';
import 'package:arraid/controllers/verificationController.dart';
import 'package:arraid/repositories/authRepository.dart';
import 'package:arraid/repositories/devisRepo.dart';
import 'package:arraid/repositories/homeRepository.dart';
import 'package:arraid/screens/HomeScreen/tabBarTabs/cmndsTab.dart';
import 'package:arraid/screens/HomeScreen/tabBarTabs/devisTab.dart';
import 'package:arraid/screens/HomeScreen/tabBarTabs/projectsTab.dart';
import 'package:arraid/screens/HomeScreen/tabBarTabs/statTab.dart';
import 'package:arraid/screens/HomeScreen/tabBarTabs/viewsTab.dart';
import 'package:arraid/screens/LoginScreen/devisScreen.dart';
import 'package:arraid/screens/LoginScreen/projectsScreen.dart';
import 'package:arraid/services/apiService.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Register the ApiService
    Get.lazyPut<ApiService>(() => ApiService('https://api.example.com'));

    // Register the AuthRepository
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find<ApiService>()));
    Get.lazyPut<DevisRepository>(() => DevisRepository(Get.find<ApiService>()));

    // Register the LoginController
    Get.lazyPut<LoginController>(
        () => LoginController(Get.find<AuthRepository>()));

    // Register the SignupController

    Get.lazyPut<SignupController>(
        () => SignupController(Get.find<AuthRepository>()));
    Get.lazyPut<DevisController>(
        () => DevisController(Get.find<DevisRepository>()));
    Get.lazyPut<ProjectsController>(
        () => ProjectsController(Get.find<DevisRepository>()));

    Get.lazyPut<VerificationController>(
        () => VerificationController(Get.find<AuthRepository>()));

    // Register the NavigationController
    Get.lazyPut<NavigationController>(() => NavigationController());
  }
}

class SignupBindings extends Bindings {
  @override
  void dependencies() {
    // Register the SignupController

    Get.lazyPut<SignupController>(
        () => SignupController(Get.find<AuthRepository>()));

    // Register the VerificationController
    Get.lazyPut<VerificationController>(
        () => VerificationController(Get.find<AuthRepository>()));
  }
}

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService('https://api.example.com'));
    Get.lazyPut<HomeNavigationController>(() => HomeNavigationController());
    Get.lazyPut<ProjetsTabController>(
        () => ProjetsTabController(Get.find<DevisRepository>()));
    Get.lazyPut<CommandsTabController>(
        () => CommandsTabController(Get.find<DevisRepository>()));
    Get.lazyPut<DevisTabController>(
        () => DevisTabController(Get.find<DevisRepository>()));
          Get.lazyPut<ViewsTabController>(
        () => ViewsTabController(Get.find<DevisRepository>()));
            Get.lazyPut<StatistiquesController>(
        () => StatistiquesController(Get.find<DevisRepository>()));

    Get.lazyPut<Homerepository>(() => Homerepository(Get.find<ApiService>()));
    Get.lazyPut<UserController>(
        () => UserController(Get.find<Homerepository>()));
    Get.lazyPut<TeamController>(
        () => TeamController(Get.find<Homerepository>()));
    Get.lazyPut<ProfileSettingsController>(
        () => ProfileSettingsController(Get.find<Homerepository>()));

    // Add other dependencies here if needed
  }
}
