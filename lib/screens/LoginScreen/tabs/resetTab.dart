import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/navigationCtrl.dart';

import 'package:arraid/controllers/signupController.dart';
import 'package:arraid/screens/LoginScreen/widgets/socialBox.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:get/get.dart';

class Resettab extends StatefulWidget {
  const Resettab({super.key});

  @override
  State<Resettab> createState() => _ResettabState();
}

class _ResettabState extends State<Resettab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

        final navigationController = Get.put(NavigationController());

    return Center(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 70,horizontal: 30),
                
                  // key: loginController.loginFormKey,
                  child: Column(
                    children: <Widget>[
                     Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                       children: [
                        IconButton(onPressed: (){
                          navigationController.goToForgotPasswordTab();
                        }, icon: Icon(MfgLabs.left_open,size:30 ,color: ColorManager.primary,)),
                        SizedBox(width:width * 0.09,),

                        
                        Center(child:  Column(
                          children: [
                            SizedBox(height: 3,),
                            Text(
                                "Reset password",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith( fontWeight: FontWeight.bold, color: ColorManager.primary,fontSize: 24),
                              ),
                                 SizedBox(
                      height:  height * 0.019,

                      ),
                      Text(

                        "Enter a new password",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 11),
                      ),
                          ],
                        ),),
                       ],
                     ),
                     
                     
 Padding(
   padding:                     const EdgeInsets.symmetric( horizontal: 0),

   child: Form(
                    // key: loginController.loginFormKey,
                    child: Column(
                      children: <Widget>[
                       
                        SizedBox(height: height * 0.03),
                        Align(
                          alignment:
                              Alignment.centerLeft, // Align text to the left
                          child: Text(
                            " Password",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                        TextFormField(
                          //controller: loginController.emailController,
                          // validator: (value) => Validator.validateEmail(value), // Use email validator
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 15),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              prefixIcon: null,
                              labelText: " New password",
                              labelStyle: Theme.of(context).textTheme.labelMedium
                              /*  TextStyle(
                                    
                                  //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                  ),
                                   */
                              ),
                        
                        ),                       
                          SizedBox(height: height * 0.0309
),   Align(
                          alignment:
                              Alignment.centerLeft, // Align text to the left
                          child: Text(
                            " Repeat password",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        SizedBox(height: height * 0.008),
                        TextFormField(
                          //controller: loginController.emailController,
                          // validator: (value) => Validator.validateEmail(value), // Use email validator
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 15),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              prefixIcon: null,
                              labelText: " Password again",
                              labelStyle: Theme.of(context).textTheme.labelMedium
                              /*  TextStyle(
                                    
                                  //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                  ),
                                   */
                              ),
                        
                        ),           
                      
                        SizedBox(height: height * 0.0297),
                        
                         
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
                        ),
                      ],),),
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
