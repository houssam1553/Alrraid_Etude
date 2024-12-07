import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:flutter/material.dart';

import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Profilescreen extends StatefulWidget {
  const Profilescreen({super.key});

  @override
  State<Profilescreen> createState() => _ProfileScreeenState();
}

class _ProfileScreeenState extends State<Profilescreen> {
  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
      Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: ColorManager.lightPrimary,
        
   
      body: Obx(() => navigationController.profileTabs[navigationController.selectedIndex1.value]),

      
     
     
    );
  }
}

