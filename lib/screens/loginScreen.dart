import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
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

    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: ColorManager.lightPrimary,
        leadingWidth: 116,
        toolbarHeight: 100,
        leading: SizedBox(
          child: Image.asset(
            'assets/images/arraidLogo.png',
           
            fit: BoxFit.cover,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(MfgLabs.menu, size: 35, color: ColorManager.black,),
            ),
          )
        ],
      ),
      body: Obx(() => navigationController.tabs[navigationController.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        
            showUnselectedLabels: false,
            currentIndex: navigationController.selectedIndex.value,
            onTap: (index) {
              navigationController.selectedIndex.value = index;
            },
            items:  [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home_24),
                label: 'home',
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
