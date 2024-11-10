import 'package:arraid/config/colors.dart';
import 'package:arraid/screens/HomeScreen/widgets/chartHeadline.dart';
import 'package:flutter/material.dart';

class ProjectsContainer extends StatelessWidget {
  const ProjectsContainer({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.67,
      padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chartHeadline(
              height: height,
              title: "Projects",
              value: "30",
              subtiltle: "done this month"),
          SizedBox(
            height: 20,
          ),
          Text(
            "Projects",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: ColorManager.greyText), // Title style
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 0.5,
            color: Color(0xFFE2E8F0),
          ),
          projectHeadline(
            imageSource: 'assets/images/proIcon1.png',
            title: "Conception d'une maison",
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 0.5,
            color: Color(0xFFE2E8F0),
          ),
          projectHeadline(
            imageSource: 'assets/images/proIcon2.png',
            title: "Realisation 100 logs",
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 0.5,
            color: Color(0xFFE2E8F0),
          ),
          projectHeadline(
            imageSource: 'assets/images/proIcon3.png',
            title: "Traitment 360",
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            thickness: 0.5,
            color: Color(0xFFE2E8F0),
          ),
          projectHeadline(
            imageSource: 'assets/images/proIcon4.png',
            title: "Exterieur maison",
          ),
        ],
      ),
    );
  }
}

class projectHeadline extends StatelessWidget {
  const projectHeadline({
    super.key,
    required this.imageSource,
    required this.title,
  });

  final String imageSource, title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns items to top
        children: [
          SizedBox(
            height: 25,
            width: 25,
            child: Image.asset(
              imageSource,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: ColorManager.primary,
              ),
              overflow: TextOverflow.visible, // Allow text to wrap
              softWrap: true, // Enables wrapping to the next line
            ),
          ),
        ],
      ),
    );
  }
}
