import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/navigationCtrl.dart';

import 'package:arraid/controllers/signupController.dart';
import 'package:arraid/widgets/signupForm.dart';
import 'package:arraid/widgets/signupHeadline.dart';
import 'package:arraid/widgets/socialBox.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';

class SignupTab extends StatefulWidget {
  const SignupTab({super.key});

  @override
  State<SignupTab> createState() => _SignuptabState();
}

class _SignuptabState extends State<SignupTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    final signupController = Get.put(Signupcontroller());
        final navigationController = Get.put(NavigationController());

    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
                child: Column(
                  children:  <Widget>[
         
                  signupHeadline(height: height),
signupForm(height: height, signupController: signupController, width: width, navigationController: navigationController),
        ],),),
            ),
          ),
        ],
      ),
    );
  }
}

