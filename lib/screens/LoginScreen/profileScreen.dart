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
            padding: const EdgeInsets.all( 25
),
            child: IconButton(
              onPressed: () {},
              icon: Icon(MfgLabs.menu, size: 33, color: ColorManager.black,),
            ),
          )
        ],
      ),
   
      body: Obx(() => navigationController.profileTabs[navigationController.selectedIndex1.value]),

      
     
     
    );
  }
}

