import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:flutter/material.dart';

import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreeen extends StatefulWidget {
  const LoginScreeen({super.key});

  @override
  State<LoginScreeen> createState() => _LoginScreeenState();
}

class _LoginScreeenState extends State<LoginScreeen> {
  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
      Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
      
   
      body: Obx(() => navigationController.bottomTabs[navigationController.selectedIndex.value]),

      
     
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: navigationController.selectedIndex.value >= 2 ? 1 : navigationController.selectedIndex.value,
        onTap: (index) {
          navigationController.changeTabIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home_24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 28, // Matching the icon size
              width: 28,
              child: Image.asset(
                'assets/images/userIcon.png',
                fit: BoxFit.contain, // Ensuring the image fits well
              ),
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.darkGrey,
        backgroundColor: ColorManager.lightGrey,
        iconSize: 28,
      )),
    );
  }
}

