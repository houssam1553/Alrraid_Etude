import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:flutter/material.dart';

import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
      Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
      
   
      body: Obx(() => navigationController.HomeTabs[navigationController.selectedIndex2.value]),

      
     
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        showUnselectedLabels: false,
        currentIndex: /* navigationController.selectedIndex2.value >= 2 ? 1 :  */navigationController.selectedIndex2.value,
        onTap: (index) {
          navigationController.changeTabIndex1(index);
        },
        items: [
            BottomNavigationBarItem(
            icon: Icon(Iconsax.home_24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                navigationController.selectedIndex2.value == 1
                    ? ColorManager.primary // Color when selected
                    : ColorManager.darkGrey, // Color when unselected
                BlendMode.srcIn,
              ),
              child: SizedBox(
                height: 22,
                width: 22,
                child: Image.asset(
                  'assets/images/dashboardIcon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: ColorFilter.mode(
                navigationController.selectedIndex2.value == 2
                    ? ColorManager.primary
                    : ColorManager.darkGrey,
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
            label: 'Profile',
          ),
        ],
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.darkGrey,
        backgroundColor: ColorManager.lightGrey,
        iconSize: 22,
      )),

    );
  }
}

