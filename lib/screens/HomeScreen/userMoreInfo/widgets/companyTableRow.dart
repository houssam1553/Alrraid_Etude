import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';

class companyTableRow extends StatelessWidget {
  const companyTableRow({
    super.key,
    required this.organization,
    required this.title,
  });
  final String organization, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.0, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            organization,
            style: TextStyle(
              fontSize: 16,
              color: ColorManager.primary,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: ColorManager.greyText), // Title style
          ),
        ],
      ),
    );
  }
}
