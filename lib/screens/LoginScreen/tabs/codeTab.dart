import 'dart:async';

import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/navigationCtrl.dart';

import 'package:arraid/controllers/signupController.dart';
import 'package:arraid/controllers/verificationController.dart';
import 'package:arraid/repositories/authRepository.dart';
import 'package:arraid/screens/LoginScreen/widgets/socialBox.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Codetab extends StatefulWidget {
  const Codetab({super.key});

  @override
  State<Codetab> createState() => _CodetabState();
}

class _CodetabState extends State<Codetab> {   
    final navigationController = Get.put(NavigationController());
    
  final VerificationController verificationController = Get.find<VerificationController>();


  @override
    void dispose() {
    verificationController.codeController.clear();
      super.dispose();
    } 
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    bool hasError = false;

 
    
    
  //   final VerificationController verificationController = Get.find<VerificationController>();
   
    StreamController<ErrorAnimationType>? errorController;

 

  
    
  

    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 70, horizontal: 30),

                // key: loginController.loginFormKey,
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              navigationController.goToSignUpTab();
                            },
                            icon: Icon(
                              MfgLabs.left_open,
                              size: 30,
                              color: ColorManager.primary,
                            )),
                        SizedBox(
                          width: width * 0.09,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "Code verification",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: ColorManager.primary,
                                        fontSize: 28),
                              ),
                              SizedBox(
                                height: height * 0.019,
                              ),
                              Text(
                                "Please type verification code \nwe sent to your email",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Form(
                        // key: loginController.loginFormKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: height * 0.1),
                            PinCodeTextField(
                              keyboardType: TextInputType.number,
                              length: 6,
                              autoDisposeControllers: false,
                              appContext: context,
                              obscureText: false,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                selectedFillColor: const Color.fromARGB(255, 218, 228, 236),
                                fieldHeight: 60,
                                fieldWidth: 45,
                                shape: PinCodeFieldShape.box,
                                borderWidth: 2,
                                borderRadius: BorderRadius.circular(10),
                                activeFillColor: Colors.white,
                                inactiveFillColor: Colors.white,
                                inactiveColor: ColorManager.primary,
                              ),
                              animationDuration:
                                  const Duration(milliseconds: 200),
                              enableActiveFill: true,
                              errorAnimationController: errorController,
                              controller: verificationController.codeController,
                              onCompleted: (v) {
                                print("Completed");
                                verificationController.verifyCode();
                                verificationController.isValide == true ? errorController!.add(ErrorAnimationType.shake) :null;
                              },
                              onChanged: (value) {
                                print(value);
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                return true;
                              },
                            ),

/*                         SizedBox(height: height * 0.0397),
                        
                         
                        SizedBox(
                          height: height * 0.0557,
                          width: width * 0.8743,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "RESET",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                            ),
                          ),
                        ), */
                          ],
                        ),
                      ),
                    ),
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
