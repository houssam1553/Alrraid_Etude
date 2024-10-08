import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/teamController.dart';
import 'package:arraid/controllers/usersController.dart';
import 'package:arraid/screens/HomeScreen/widgets/teamContainer.dart';
import 'package:arraid/screens/HomeScreen/widgets/usersContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Teammemberspage extends StatefulWidget {
  const Teammemberspage({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  _TeammemberspageState createState() => _TeammemberspageState();
}

class _TeammemberspageState extends State<Teammemberspage> {
  final TeamController teamController = Get.find<TeamController>();

  @override
  void initState() {
    super.initState();
    teamController.loadTeamMembers(); // Call to load users during initialization
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Using Obx to reactively listen for loading state changes
      if (teamController.isLoading.value) {
        return  Center(
       
            child: CircularProgressIndicator(color: ColorManager.primary,
                    backgroundColor: ColorManager.greyText,),
          
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: widget.height * 0.015),
            TeamContainer(
              width: widget.width,
              height: widget.height,
              teamController: teamController,
            ),
          ],
        ),
      );
    });
  }
}
