import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/homeNavigationCtrl.dart';
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
    final navigationController = Get.put(HomeNavigationController());
      Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
      
   
   

  body: Obx(() => navigationController.HomeTabs.isNotEmpty
          ? navigationController.HomeTabs[navigationController.selectedIndex.value]
          : Center(child: CircularProgressIndicator())), // Show loading if HomeTabs is empty
          
      bottomNavigationBar: Obx(() {
        // Only show BottomNavigationBar if there are items to show
        return navigationController.bottomNavigationItems.isNotEmpty
            ? BottomNavigationBar(
                showUnselectedLabels: false,
                currentIndex: navigationController.selectedIndex.value >= 3 ? 1 : navigationController.selectedIndex.value,
                onTap: (index) {
                  navigationController.changeTabIndex1(index);
                },
                items: navigationController.bottomNavigationItems,
                selectedItemColor: ColorManager.primary,
                unselectedItemColor: ColorManager.darkGrey,
                backgroundColor: ColorManager.lightGrey,
                iconSize: 22,
              )
            : SizedBox.shrink(); // Hide the BottomNavigationBar if there are no items
      }),


    );
  }
}

