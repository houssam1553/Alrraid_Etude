import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';

class usersProgress extends StatelessWidget {
  const usersProgress({
    super.key,
    required this.width,
    required this.height, required this.value, required this.title, required this.icon,
  });
final String value , title;
  final double width;
  final double height;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width*0.27,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(15)),
                  color: ColorManager
                      .primary, // Background color of icon container
                  //shape: BoxShape.circle, // Make the container circular
                ),
                child: Icon(
                  icon, // Replace with your icon
                  color: Colors.white,
                  size: 24, // Adjust icon size
                ),
              ),SizedBox(width: 10,),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: ColorManager
                            .greyText), // Title style
              ),
            ],
          ),  SizedBox(
        height: height * 0.01,
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          color: ColorManager.primary,
        ), // First text style
      ),
      SizedBox(
        height: height * 0.007,
      ),
      LinearProgressIndicator(value: 0.6,borderRadius: BorderRadius.circular(10),backgroundColor: Color(0xFFE2E8F0),color: ColorManager.primary,)
      
        ],
      ),
    );
  }
}