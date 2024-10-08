import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/loginController.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/screens/LoginScreen/widgets/loginForm.dart';
import 'package:arraid/screens/LoginScreen/widgets/loginHeadline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logintab extends StatefulWidget {

  @override
  State<Logintab> createState() => _LogintabState();
}

class _LogintabState extends State<Logintab> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
     final LoginController loginController = Get.find<LoginController>();

    final navigationController = Get.put(NavigationController());
    
    


    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 110, horizontal: 30),
                    
                     child: Column(
                    children: <Widget>[
                      loginHeadline(height: height),
                loginForm(height: height, loginController: loginController, navigationController: navigationController, width: width),
                    ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



