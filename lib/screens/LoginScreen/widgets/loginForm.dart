import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/config/validator.dart';
import 'package:arraid/controllers/loginController.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class loginForm extends StatefulWidget {
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
  _loginFormState createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
  @override
  void dispose() {
    // Clear text controllers when the login form is disposed
    widget.loginController.emailController.clear();
    widget.loginController.passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.loginController.loginFormKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: widget.height * 0.0532),
          formInput(
            height: widget.height,
            togglePasswordVisibility: () {},
            obscureText: false,
            label: "Email",
            hint: "Your email address",
            textEditingController: widget.loginController.emailController,
            inputType: InputType.email,
          ),
          SizedBox(height: widget.height * 0.01),
          Obx(
            () => formInput(
              height: widget.height,
              label: "Password",
              hint: "Your password",
              textEditingController: widget.loginController.passwordController,
              inputType: InputType.password,
              obscureText: widget.loginController.obscurePassword.value,
              togglePasswordVisibility:
                  widget.loginController.togglePasswordVisibility,
            ),
          ),
          SizedBox(height: widget.height * 0.02),
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
                  Text(
                    " Remember me",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: ColorManager.TextColor,
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  widget.navigationController.goToForgotPasswordTab();
                },
                child: Text(
                  "Forgot password",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold, color: ColorManager.primary),
                ),
              ),
            ],
          ),
          SizedBox(height: widget.height * 0.037),
          SizedBox(
            height: widget.height * 0.0557,
            width: widget.width * 0.8743,
            child: ElevatedButton(
              onPressed: widget.loginController.login,
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
          SizedBox(height: widget.height * 0.017),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " Do not have an account?",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
                TextButton(
                    onPressed: () {
                      widget.navigationController.goToSignUpTab();
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
