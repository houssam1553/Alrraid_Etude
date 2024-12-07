import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final NavigationController navigationController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
      body: Obx(() {
        return IndexedStack(
          index: navigationController.selectedIndex.value,
          children: navigationController.bottomTabs,
        );
      }),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: navigationController.selectedIndex.value,
        onTap: (index) {
          navigationController.changeTabIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Iconsax.home_24),
            label: 'Home',
          ),
            BottomNavigationBarItem(
            icon: Icon(Iconsax.edit),
            label: 'Devis',
          ),
          BottomNavigationBarItem(
              label: 'Profile',
            icon:
          Obx(() => ColorFiltered(
            
      colorFilter: ColorFilter.mode(
     navigationController.   selectedIndex.value == 2
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
    )),),
        ],
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.darkGrey,
        backgroundColor: ColorManager.lightGrey,
        iconSize: 28,
      )),
    );
  }
}
