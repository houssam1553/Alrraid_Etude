import 'package:arraid/screens/HomeScreen/tabs/cming.dart';
import 'package:arraid/screens/HomeScreen/tabs/dashboardTab.dart';
import 'package:arraid/screens/HomeScreen/tabs/profileSettingsTab.dart';
import 'package:arraid/screens/LoginScreen/loginScreen.dart';
import 'package:arraid/screens/LoginScreen/profileScreen.dart';
import 'package:arraid/screens/LoginScreen/tabs/forgotTab.dart';
import 'package:arraid/screens/LoginScreen/landingScreen.dart';
import 'package:arraid/screens/LoginScreen/tabs/loginTab.dart';
import 'package:arraid/screens/LoginScreen/tabs/resetTab.dart';
import 'package:arraid/screens/LoginScreen/tabs/signupTab.dart';
 // New ProfileTab for Profile section
import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  var selectedIndex1 = 0.obs;
  var selectedIndex2 = 1.obs;



  // Tabs for BottomNavigationBar (Home and Profile)
  final bottomTabs = [
    landingScreen(), // Home Tab
    Profilescreen(), // Profile Main Tab
  ];

  // Profile-related tabs (Login, Signup, ForgotPassword, Reset)
  final profileTabs = [
    Logintab(),
    SignupTab(),
    ForgotpassTab(),
    Resettab(),
  ];

  final HomeTabs = [
 landingScreen(),
 DashboardTab(),
 //Cming(),
 ProfileSettingsTab(),
  ];

  void changeTabIndex(int index) {
    if (index >= 0 && index < bottomTabs.length) {
      selectedIndex.value = index;
    }
  }
  
  void changeTabIndex1(int index) {
    if (index >= 0 && index < HomeTabs.length) {
      selectedIndex2.value = index;
    }
  }

 void goToSigninTab() {
    selectedIndex1.value = 0; // Example, assign profile tabs index
  }
  // Methods to navigate to profile-related tabs
  void goToSignUpTab() {
    selectedIndex1.value = 1; // Example, assign profile tabs index
  }

  void goToForgotPasswordTab() {
    selectedIndex1.value = 2;
  }

  void goToResettab() {
    selectedIndex1.value = 3;
  }
  void gotoProfile() {
    selectedIndex2.value = 2;
  }
}
