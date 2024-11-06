import 'package:arraid/config/colors.dart';
import 'package:arraid/models/userModel.dart';
import 'package:arraid/screens/HomeScreen/tabs/dashboardTab.dart';
import 'package:arraid/screens/HomeScreen/tabs/profileSettingsTab.dart';
import 'package:arraid/screens/LoginScreen/landingScreen.dart';
import 'package:arraid/screens/HomeScreen/userMoreInfo/profileInfoScreen.dart';
import 'package:arraid/services/LocalService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeNavigationController extends GetxController {
  var selectedIndex = 1.obs;
  User? currentUser;

  final HomeTabs = <Widget>[].obs;
  final bottomNavigationItems = <BottomNavigationBarItem>[].obs;

     @override
  void onInit() {
    super.onInit();
    // Fetch the current user from local storage
    loadCurrentUser();
  }

  void loadCurrentUser() async {
  currentUser = await LocalService.getUser();





  if (currentUser != null) {
      print(currentUser!.isEmployee);
  print(currentUser!.email);
  print(currentUser!.type);

    if (currentUser!.isEmployee == 'true') {
      HomeTabs.value = [
        landingScreen(),
        DashboardTab(),
        ProfileSettingsTab(),
        ProfileInfoscreen(),
      ];

      // Define navigation items for an employee
      bottomNavigationItems.value = [
   
  BottomNavigationBarItem(
    icon: Obx(() => Icon(
      Iconsax.home_24,
      size: 25,
      color: selectedIndex.value == 0
          ? ColorManager.primary // Selected color
          : ColorManager.darkGrey, // Unselected color
    )),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Obx(() => ColorFiltered(
      colorFilter: ColorFilter.mode(
        selectedIndex.value == 1
            ? ColorManager.primary // Selected color
            : ColorManager.darkGrey, // Unselected color
        BlendMode.srcIn,
      ),
      child: SizedBox(
        height: 25,
        width: 25,
        child: Image.asset(
          'assets/images/dashboardIcon.png',
          fit: BoxFit.contain,
        ),
      ),
    )),
    label: 'Dashboard',
  ),
  BottomNavigationBarItem(
    icon: Obx(() => ColorFiltered(
      colorFilter: ColorFilter.mode(
        selectedIndex.value == 2
            ? ColorManager.primary // Selected color
            : ColorManager.darkGrey, // Unselected color
        BlendMode.srcIn,
      ),
      child: SizedBox(
        height: 25,
        width: 25,
        child: Image.asset(
          'assets/images/userIcon.png',
          fit: BoxFit.contain,
        ),
      ),
    )),
    label: 'Profile',
  ),
];

      
    } else {
      // Normal user home tabs and items
      HomeTabs.value = [
        landingScreen(),
        ProfileSettingsTab(),
      ];

      // Only show basic navigation items
      bottomNavigationItems.value = [
        BottomNavigationBarItem(
          icon: Icon(
            Iconsax.home_24,
            size: 25,
            color: selectedIndex.value == 0
                ? ColorManager.primary // Selected color
                : ColorManager.darkGrey, // Unselected color
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon:  Obx(() => ColorFiltered(
            colorFilter: ColorFilter.mode(
              selectedIndex.value == 1
                  ? ColorManager.primary // Selected color
                  : ColorManager.darkGrey, // Unselected color
              BlendMode.srcIn,
            ),
            child: SizedBox(
              height: 22,
              width: 22,
              child: Image.asset(
                'assets/images/userIcon.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
           ),
          label: 'Profile',
        ),
      ];
    }
  }
}

   void gotoProfileSett() {
    selectedIndex.value = 2;
  }
    void gotoProfile() {
    selectedIndex.value = 3;
  }
  void gotoDashboard() {
    selectedIndex.value = 1;
  }
  void changeTabIndex1(int index) {
    if (index >= 0 && index < HomeTabs.length) {
      selectedIndex.value = index;
    }else{    selectedIndex.value = 3;}
  }

  void changeHomeTabIndex(int index) {
    if (index >= 0 && index < HomeTabs.length) {
      selectedIndex.value = index;
    }
  }
}
