import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/homeNavigationCtrl.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/controllers/teamController.dart';
import 'package:arraid/screens/HomeScreen/userMoreInfo/widgets/orgTable.dart';
import 'package:arraid/screens/HomeScreen/userMoreInfo/widgets/profileHeadline.dart';
import 'package:arraid/screens/HomeScreen/userMoreInfo/widgets/projectsTable.dart';
import 'package:arraid/screens/HomeScreen/widgets/chartHeadline.dart';
import 'package:arraid/screens/HomeScreen/widgets/projectsContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileInfoscreen extends StatefulWidget {
  const ProfileInfoscreen({super.key});

  @override
  State<ProfileInfoscreen> createState() => _ProfileInfoscreenState();
}

class _ProfileInfoscreenState extends State<ProfileInfoscreen> {
  final TeamController teamController = Get.find<TeamController>();
  final HomeNavigationController navigationController = Get.find<HomeNavigationController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2, color: Colors.black,size: 30,), // Back icon
          onPressed: () {
            navigationController.gotoDashboard();
             // Go back to the previous screen
          },
        ),
        title: Text(
          "Profile Info",
          style: TextStyle(color: ColorManager.primary),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
                child: profileHeadline(
                  width: width,
                  name: teamController.currentTeamMember,
                ),
              ),
              orgTable(),
              SizedBox(height: height * 0.05),
              Container(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    chartHeadline(
                      height: height,
                      title: "Projects",
                      value: "30",
                      subtiltle: "done this month",
                    ),
                    SizedBox(height: height * 0.01),
                    projTable(height: height, width: width),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
