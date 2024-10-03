import 'package:arraid/config/colors.dart';

import 'package:arraid/screens/LoginScreen/widgets/socialBox.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class signupHeadline extends StatelessWidget {
  const signupHeadline({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Register with",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold,color: ColorManager.TextColor,letterSpacing: 0.5,fontSize: 18),
        ),
        SizedBox(
          height: height * 0.0281,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35
    ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceAround, // Evenly space the icons
            children: [
              // Facebook Box
              SocialMediaBox(
                color: Colors.blue[800]!,
                icon: FontAwesome5.facebook,
                onPressed: () {
                  // Handle Facebook sign-up
                },
              ),
          
              // Google Box
              SocialMediaBox(
                color: Colors.red[700]!,
                icon: FontAwesome5.apple,
                onPressed: () {
                  // Handle Google sign-up
                },
              ),
          
              // Twitter Box
              SocialMediaBox(
                color: Colors.lightBlueAccent,
                icon: FontAwesome5.google,
                onPressed: () {
                  // Handle Twitter sign-up
                },
              ),
            ],
          ),
        ),
         SizedBox(
          height: height * 0.028,
        ),
         Text(
          "or",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold,fontSize: 18, color: ColorManager.greyText),
        ),]);
  }
}
