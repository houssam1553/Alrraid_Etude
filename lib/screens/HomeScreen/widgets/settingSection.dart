import 'package:arraid/config/colors.dart';
import 'package:arraid/screens/HomeScreen/tabs/profileSettingsTab.dart';
import 'package:flutter/material.dart';

class settingsSection extends StatelessWidget {
  const settingsSection({
    super.key,
    required this.width,
    required this.child,
    required this.title,


  });

  final double width;
final String title;
final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // This allows the text to overflow the container if needed
      children: [
        // The container with the border
        Container(width: width*0.9,
        child: child,
        
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              color: Colors.blueGrey.shade200, // Customize border color
              width: 1, // Customize border width
            ),
          ),
        ),
        
        // Positioned text on top of the border
        Positioned(
          left: 20,
          top: -15, // Adjust the top value to move the text above the border
          child: Container(
            color: ColorManager.lightPrimary, // Background color to avoid overlap with the border
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class switchText extends StatelessWidget {
  const switchText({
    required this.label,
    super.key,
  });
final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
                      children: [
                          Transform.scale(scale: 0.8,
                     child: Switch(
                              value: true,
                              onChanged: (bool value1){},
                            ),
                     ),
                        Text(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: ColorManager.TextColor,
                            fontWeight: FontWeight.normal,
          
                        )),
                      ],
                    );
  }
}

