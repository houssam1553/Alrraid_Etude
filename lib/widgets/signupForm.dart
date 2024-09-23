import 'package:arraid/config/colors.dart';
import 'package:arraid/controllers/navigationCtrl.dart';

import 'package:arraid/controllers/signupController.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

class signupForm extends StatelessWidget {
  const signupForm({
    super.key,
    required this.height,
    required this.signupController,
    required this.width,
    required this.navigationController,
  });

  final double height;
  final Signupcontroller signupController;
  final double width;
  final NavigationController navigationController;

  @override
  Widget build(BuildContext context) {
    return Form(
                      // key: loginController.loginFormKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: height * 0.0210
    ),
    
    Align(
                            alignment:
                                Alignment.centerLeft, // Align text to the left
                            child: Text(
                              " Name",
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
                                labelText: "Your full name",
                                labelStyle: Theme.of(context).textTheme.labelMedium
                                /*  TextStyle(
                                      
                                    //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                    ),
                                     */
                                ),
                          
                          ),
                          SizedBox(height: height * 0.0309
),
                          Align(
                            alignment:
                                Alignment.centerLeft, // Align text to the left
                            child: Text(
                              " Email",
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
                                labelText: "Your email address",
                                labelStyle: Theme.of(context).textTheme.labelMedium
                                /*  TextStyle(
                                      
                                    //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                    ),
                                     */
                                ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                         SizedBox(height: height * 0.0309
),
                          Align(
                            alignment:
                                Alignment.centerLeft, // Align text to the left
                            child: Text(
                              " Password",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          SizedBox(height: height * 0.008),
                          Obx(() => TextFormField(
                                controller: signupController.passwordController,
                                obscureText: signupController.obscurePassword.value,
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 25.0, vertical: 15),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                          borderSide: BorderSide( color: const Color(0xFFE2E8F0), // Border color
            width: 1.5,)
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        signupController.obscurePassword.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed:
                                          signupController.togglePasswordVisibility,
                                    ),
                                    labelText: "Your password",
                                    labelStyle:
                                        Theme.of(context).textTheme.labelMedium
                                    /*  TextStyle(
                                      
                                    //  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                    ),
                                     */
                                    ),
                                keyboardType: TextInputType.visiblePassword,
                              )),
                          SizedBox(height: height * 0.0197),
                          
                              Row(
                                children: [
                                 Transform.scale(scale: 0.7,
                 child: Switch(
                          value: true,
                          onChanged: (bool value1){},
                        ),
                 ),
                                  Text(" Remember me",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                            color: ColorManager.TextColor,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.normal,
                                          )),
                                ],
                              ),
                              // Align text to the left
    
                            
                          
                          SizedBox(height: height * 0.03),
                          SizedBox(
                            height: height * 0.0557,
                            width: width * 0.8743,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "SIGN UP",
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
                          SizedBox(height: height * 0.0172),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(" Allready have an account?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.normal,
                                        )),
                                     TextButton(onPressed: (){
                                navigationController.goToSigninTab();
                              }, child: Text(" Sign in",
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: ColorManager.primary
                                        ),))       
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
  }
}

