import 'package:arraid/config/colors.dart';
import 'package:arraid/models/userModel.dart';
import 'package:arraid/screens/HomeScreen/userMoreInfo/profileInfoScreen.dart';
import 'package:arraid/screens/HomeScreen/tabs/cming.dart';
import 'package:arraid/screens/HomeScreen/tabs/dashboardTab.dart';
import 'package:arraid/screens/HomeScreen/tabs/profileSettingsTab.dart';
import 'package:arraid/screens/LoginScreen/loginScreen.dart';
import 'package:arraid/screens/LoginScreen/profileScreen.dart';
import 'package:arraid/screens/LoginScreen/tabs/codeTab.dart';
import 'package:arraid/screens/LoginScreen/tabs/forgotTab.dart';
import 'package:arraid/screens/LoginScreen/landingScreen.dart';
import 'package:arraid/screens/LoginScreen/tabs/loginTab.dart';
import 'package:arraid/screens/LoginScreen/tabs/resetTab.dart';
import 'package:arraid/screens/LoginScreen/tabs/signupTab.dart';
import 'package:arraid/services/LocalService.dart';
import 'package:flutter/material.dart';
 // New ProfileTab for Profile section
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  var selectedIndex1 = 0.obs;




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
    Codetab()
  ];

   
  

  void changeTabIndex(int index) {
    if (index >= 0 && index < bottomTabs.length) {
      selectedIndex.value = index;
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
   void goToCodetab() {
    selectedIndex1.value = 4;
  }
 

}
