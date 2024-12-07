import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class TabBarController extends GetxController {
  // Tracks the active widget for each tab
  final Map<int, Rx<Widget>> activeTabViews = {};

  @override
  void onInit() {
    super.onInit();
    // Initialize the views for each tab
    activeTabViews[0] = Rx<Widget>(defaultStatistiquesView());
    activeTabViews[1] = Rx<Widget>(defaultProjetsView());
    activeTabViews[2] = Rx<Widget>(defaultUtilisateursView());
  }


  void updateTabView(int tabIndex, Widget newView) {
    activeTabViews[tabIndex]?.value = newView;
  }
  var currentTabIndex = 0.obs;

  void changeTab(int index) {
    currentTabIndex.value = index;
  }
}

// Default views for tabs
Widget defaultStatistiquesView() => Center(child: Text("Default Statistiques Content"));
Widget defaultProjetsView() => Center(child: Text("Default Projets Content"));
Widget defaultUtilisateursView() => Center(child: Text("Default Utilisateurs Content"));
