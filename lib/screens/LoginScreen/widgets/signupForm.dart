import 'package:arraid/commun%20widgets/formInput.dart';
import 'package:arraid/config/colors.dart';
import 'package:arraid/config/enums.dart';
import 'package:arraid/controllers/navigationCtrl.dart';
import 'package:arraid/controllers/signupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class signupForm extends StatefulWidget {
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
  _signupFormState createState() => _signupFormState();
}

class _signupFormState extends State<signupForm> {
  @override
  void dispose() {
    // Clear the controllers when the form is disposed
    widget.signupController.firstNameController.clear();
    widget.signupController.lastNameController.clear();
    widget.signupController.emailController.clear();
    widget.signupController.passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.signupController.signupFormKey,
      child: Column(
        children: <Widget>[
          SizedBox(height: widget.height * 0.0210),
          Row(
            children: [
              SizedBox(
                width: widget.width * 0.4,
                child: formInput(
                  height: widget.height,
                  obscureText: false,
                  label: 'First name',
                  hint: "Your first name",
                  textEditingController:
                      widget.signupController.firstNameController,
                  inputType: InputType.name,
                  togglePasswordVisibility: () {},
                ),
              ),
              SizedBox(width: widget.width * 0.0309),
              SizedBox(
                width: widget.width * 0.4,
                child: formInput(
                  height: widget.height,
                  obscureText: false,
                  label: 'Last name',
                  hint: "Your last name",
                  textEditingController:
                      widget.signupController.lastNameController,
                  inputType: InputType.name,
                  togglePasswordVisibility: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: widget.height * 0.0309),
          formInput(
            height: widget.height,
            togglePasswordVisibility: () {},
            obscureText: false,
            label: "Email",
            hint: "Your email address",
            textEditingController: widget.signupController.emailController,
            inputType: InputType.email,
          ),
          SizedBox(height: widget.height * 0.0309),
          Obx(
            () => formInput(
              height: widget.height,
              label: "Password",
              hint: "Your password",
              textEditingController:
                  widget.signupController.passwordController,
              inputType: InputType.password,
              obscureText: widget.signupController.obscurePassword.value,
              togglePasswordVisibility:
                  widget.signupController.togglePasswordVisibility,
            ),
          ),
          SizedBox(height: widget.height * 0.0197),
          Row(
            children: [
              Transform.scale(
                scale: 0.7,
                child: Switch(
                  value: true,
                  onChanged: (bool value1) {},
                ),
              ),
              Text(
                "Remember me",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: ColorManager.TextColor,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
          SizedBox(height: widget.height * 0.03),
          SizedBox(
            height: widget.height * 0.0557,
            width: widget.width * 0.8743,
            child: ElevatedButton(
              onPressed: widget.signupController.signUp,
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
          SizedBox(height: widget.height * 0.0172),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
                TextButton(
                  onPressed: () {
                    widget.navigationController.goToSigninTab();
                  },
                  child: Text(
                    "Sign in",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorManager.primary,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
