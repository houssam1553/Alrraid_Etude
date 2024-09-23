import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
class SidebarController extends GetxController {
  var selectedIndex = 0.obs;
  var expandedIndex = (-1).obs; // Initially, no item is expanded
  late PageController pageController;

  SidebarController() {
    // Initialize PageController
    pageController = PageController();
  }

  @override
  void onClose() {
    // Dispose the controller when no longer needed
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
        pageController.jumpToPage(index);
        print('Successfully jumped to page $index');
      } catch (e) {
        print('Error occurred while jumping to page: $e');
      }
    } else {
      print('PageController is not attached to any scroll views.');
    }
  }
}
