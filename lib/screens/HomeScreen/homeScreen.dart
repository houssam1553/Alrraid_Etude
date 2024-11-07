import 'package:arraid/config/bindings/appBindings.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/homeNavigationCtrl.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:flutter/material.dart';

import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<Homescreen> {
  DateTime? lastPressed;

  @override
  void initState() {
    super.initState();
    // Initialize bindings
    HomeBindings().dependencies();
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 2)) {
      lastPressed = now;
      Fluttertoast.showToast(msg: 'Press again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(HomeNavigationController());
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: ColorManager.lightPrimary,
        body: Obx(() => navigationController.HomeTabs.isNotEmpty
            ? navigationController.HomeTabs[navigationController.selectedIndex.value]
            : Center(
                child: CircularProgressIndicator(
                  color: ColorManager.primary,
                  backgroundColor: ColorManager.greyText,
                ),
              )), // Show loading if HomeTabs is empty
        bottomNavigationBar: Obx(() {
          // Only show BottomNavigationBar if there are items to show
          return navigationController.bottomNavigationItems.isNotEmpty
              ? BottomNavigationBar(
                  showUnselectedLabels: false,
                  currentIndex: navigationController.selectedIndex.value >= 3
                      ? 1
                      : navigationController.selectedIndex.value,
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
      ),
    );
  }
}
