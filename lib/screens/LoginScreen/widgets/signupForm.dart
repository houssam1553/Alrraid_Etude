import 'package:arraid/commun%20widgets/customInput.dart';
import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/config/validator.dart';
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
  final SignupController signupController;
  final double width;
  final NavigationController navigationController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signupController.signupFormKey,
      // key: loginController.loginFormKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: height * 0.0210),
        Row(
  children: [
    SizedBox(
      width: width*0.4,
      child: formInput(
          height: height,
        obscureText: false,
          label: ' First name',
          hint: "Your first name",
          textEditingController: signupController.firstNameController, inputType: InputType.name, togglePasswordVisibility: () {  },
        ),
    ),
    
    SizedBox(width: width * 0.0309),
    SizedBox(
      width: width*0.4,
      child:
   formInput(
        height: height,
        obscureText: false,

     
        label: ' Last name',
        hint: "Your last name",
          textEditingController: signupController.lastNameController, inputType: InputType.name, togglePasswordVisibility: () {  },
      ),),
    
  ],
),


          SizedBox(height: height * 0.0309),
          formInput(
             height: height,
            togglePasswordVisibility: () {},
            obscureText: false,
            label: "Email",
            hint: "Your email address",
            textEditingController: signupController.emailController,
            inputType: InputType.email,
          
          ),

          SizedBox(height: height * 0.0309),
        
        Obx(
            () => formInput(
            height: height,
              label: "Password",
              hint: "Your password",
              textEditingController: signupController.passwordController,
              inputType: InputType.password,
              obscureText: signupController.obscurePassword
                  .value, // Bind the obscure text to the controller
              togglePasswordVisibility:
                  signupController.togglePasswordVisibility,
            ),
          ),
          SizedBox(height: height * 0.0197),

          Row(
            children: [
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: true,
                  onChanged: (bool value1) {},
                ),
              ),
              Text(" Remember me",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
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
              onPressed:signupController.signUp,
              child: Text(
                "SIGN UP",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
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
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.normal,
                        )),
                TextButton(
                    onPressed: () {
                      navigationController.goToSigninTab();
                    },
                    child: Text(
                      " Sign in",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primary),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}


