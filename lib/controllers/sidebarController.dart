import 'dart:math';

import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
class SidebarController extends GetxController {
  var selectedIndex = 0.obs;
  var expandedIndex = (-1).obs; // Initially, no item is expanded
  late PageController pageController;
  late SideMenuController sideMenuController;

  SidebarController() {
    // Initialize PageController
    pageController = PageController();
    sideMenuController = SideMenuController();
  }
@override
  void onInit() {
 
    
    // TODO: implement onInit
    // Sync SideMenuController with selected index on initialization
    
     sideMenuController.addListener((int page) {
      if (page != selectedIndex.value) {
        selectedIndex.value = page;
        pageController.jumpToPage(page);
      }
    });

   
    super.onInit();
  }
  @override
  void onClose() {
    // Dispose the controller when no longer needed
   sideMenuController.dispose();
    pageController.dispose();
     
    super.onClose();
  } 

  void changeIndex(int index) {
    print(index);
    selectedIndex.value = index;
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; // Collapse
    } else {
      expandedIndex.value = index; // Expand
    }
  }

  void selectChildIndex(int index) {
    selectedIndex.value = index;
    print('Attempting to jump to page $index');

    if (pageController.hasClients) {
      try {
       
              pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 500), // Adjust the duration as needed
          curve: Curves.easeInOutQuart, // Use Flutter's built-in curves
        );

        print('Successfully jumped to page $index');
      } catch (e) {
        print('Error occurred while jumping to page: $e');
      }
    } else {
      print('PageController is not attached to any scroll views.');
    }
  }
}
