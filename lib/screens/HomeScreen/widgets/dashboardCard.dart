import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';

class dashboardCard extends StatelessWidget {
  const dashboardCard({
    super.key,
    required this.width,
    required this.icon,

    required this.title,
    required this.value,
    required this.precentage,
  });
  final String title, value, precentage;
  final double width;
  final Icon icon;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      // width: width * 0.7,
      //height: 95,
      child: Card(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0), // Add padding inside the card
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Align the icon and content vertically
            children: [
              // Left Column (Title and two texts)
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align content to the left
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 12,
                        color: ColorManager.greyText), // Title style
                  ),
                  SizedBox(height: 8), // Spacing between title and row of texts
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start, // Align texts to the start
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorManager.primary,
                        ), // First text style
                      ),
                      SizedBox(width: 16), // Spacing between the two texts
                      Text(
                        precentage,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ), // Second text style
                      ),
                    ],
                  ),
                ],
              ),
              // Right Container with Icon
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: ColorManager
                      .primary, // Background color of icon container
                  //shape: BoxShape.circle, // Make the container circular
                ),
                child:icon
              ),
            ],
          ),
        ),
      ),
    );
  }
}
