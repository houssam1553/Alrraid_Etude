import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';

class chartHeadline extends StatelessWidget {
  const chartHeadline({
    super.key,
    required this.height, required this.title, required this.subtiltle, required this.value,
  });
final String title,subtiltle,value;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: ColorManager.primary,
          ), // First text style
        ),
        SizedBox(
          height: height * 0.007,
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: ColorManager.green,
              ), // First text style
            ),
            SizedBox(
              width: 5,
            ),
            Text(
             subtiltle,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: ColorManager
                          .greyText), // Title style
            ),
          ],
        ),
      ],
    );
  }
}
