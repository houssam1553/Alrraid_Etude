import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class profileHeadline extends StatelessWidget {
  const profileHeadline({
    super.key,
    required this.width,
    required this.name,

  });

  final double width;
  
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/profile.png',
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorManager.primary,
                ),
                width: 30,
                height: 30,
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Iconsax.edit,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: width * 0.075),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(9, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(name!),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: Column(
                  children: [
                    Text(
                      "Views",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: ColorManager.greyText), // Title style
                    ),
                    Text(
                      "  2,324",
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorManager.primary,
                      ), // First text style
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
