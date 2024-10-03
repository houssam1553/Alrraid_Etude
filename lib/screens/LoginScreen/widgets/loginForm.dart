import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/config/validator.dart';
import 'package:arraid/controllers/loginController.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/screens/HomeScreen/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class loginForm extends StatelessWidget {
  const loginForm({
    super.key,
    required this.height,
    required this.loginController,
    required this.navigationController,
    required this.width,
  });

  final double height;
  final LoginController loginController;
  final NavigationController navigationController;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginController.loginFormKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: height * 0.0532),
          formInput(
            height: height,
            togglePasswordVisibility: () {},
            obscureText: false,
            label: "Email",
            hint: "Your email address",
            textEditingController: loginController.emailController,
            inputType: InputType.email,
          ),
          SizedBox(height: height * 0.01),
          Obx(
            () => formInput(
              height: height,
              label: "Password",
              hint: "Your password",
              textEditingController: loginController.passwordController,
              inputType: InputType.password,
              obscureText: loginController.obscurePassword
                  .value, // Bind the obscure text to the controller
              togglePasswordVisibility:
                  loginController.togglePasswordVisibility,
            ),
          ),
          SizedBox(height: height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: true,
                      onChanged: (bool value1) {},
                    ),
                  ),
                  Text(" Remember me",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: ColorManager.TextColor,
                            fontWeight: FontWeight.normal,
                          )),
                ],
              ),
              // Align text to the left

              TextButton(
                onPressed: () {
                  navigationController.goToForgotPasswordTab();
                },
                child: Text(
                  "Forgot password",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: ColorManager.primary),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.037),
          SizedBox(
            height: height * 0.0557,
            width: width * 0.8743,
            child: ElevatedButton(
              onPressed: loginController.login,
              child: Text(
                "SIGN IN",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Colors.white,
                    ),
              ),
            ),
          ),
          SizedBox(height: height * 0.017),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(" Do not have an account?",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.normal,
                        )),
                TextButton(
                    onPressed: () {
                      navigationController.goToSignUpTab();
                    },
                    child: Text(
                      " Sign Up",
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
