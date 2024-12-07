import 'package:flutter/material.dart';
import 'package:arraid/config/colors.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String Url;

  final double rating;

  const ProjectCard({
    Key? key,
    this.imageUrl = '', // Default to empty string if null
     this.Url = '',
    this.title = 'Untitled Project', // Default title if null
    this.subtitle = 'No description available', // Default subtitle if null
    this.rating = 0.0, // Default rating if null
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Card(
       color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
     elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project image
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            child: Image.network(
              imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
               errorBuilder: (context, error, stackTrace) {
          return Container(
           
            alignment: Alignment.center,
           child: Image.asset("assets/images/default.png")
          );
        },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorManager.black,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                      SizedBox(height: 8),
                      // Rating stars
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: index < rating ? Colors.black : Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Right arrow icon
             IconButton(
  onPressed: () async {
    var uri = Uri.parse(Url); // Convert String to Uri
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Handle failure to launch URL (optional)
      Get.snackbar('Error', 'Could not launch the project URL.');
    }
  },
  icon: Icon(
    Icons.arrow_forward,
    color: ColorManager.black,
    size: 24,
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
