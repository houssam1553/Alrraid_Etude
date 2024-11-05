import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/config/validator.dart';
import 'package:arraid/controllers/loginController.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
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
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    widget.loginController .checkRememberedCredentials();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose of the text controllers if needed
 
  }

  // Method to handle "Forgot Password" link
  Future<void> _handleForgotPassword() async {
    var url = Uri.https("alrraid.com", "/en/auth/forget-password");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      // Handle failure to launch URL (optional)
      Get.snackbar('Error', 'Could not launch the forgot password page.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: widget.height * 0.0532),
          formInput(
            height: widget.height,
            togglePasswordVisibility: widget.loginController.togglePasswordVisibility,
            obscureText: false,
            label: "Email",
            hint: "Your email address",
            textEditingController: widget.loginController.emailController,
            inputType: InputType.email,
             // Add a validator for the email field
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
              togglePasswordVisibility: widget.loginController.togglePasswordVisibility,
         // Add a password validator
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
                    child: Obx(
                      () => Switch(
                        value: widget.loginController.rememberMe.value,
                        onChanged: (bool value) {
                          widget.loginController.rememberMe.value = value;
                        },
                      ),
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
                onPressed: _handleForgotPassword, // Call method for forgot password
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
              onPressed: () async {
                if (_loginFormKey.currentState!.validate()) {
                  // Trigger login logic when the form is valid
                  await widget.loginController.login();
                }
              },
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
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
