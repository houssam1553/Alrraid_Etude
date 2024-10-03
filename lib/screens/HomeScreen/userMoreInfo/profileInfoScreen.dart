import 'package:arraid/config/colors.dart';
import 'package:arraid/screens/HomeScreen/userMoreInfo/widgets/orgTable.dart';
import 'package:arraid/screens/HomeScreen/userMoreInfo/widgets/profileHeadline.dart';
import 'package:arraid/screens/HomeScreen/userMoreInfo/widgets/projectsTable.dart';
import 'package:arraid/screens/HomeScreen/widgets/chartHeadline.dart';
import 'package:arraid/screens/HomeScreen/widgets/projectsContainer.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileInfoscreen extends StatefulWidget {
  const ProfileInfoscreen({super.key});

  @override
  State<ProfileInfoscreen> createState() => _ProfileInfoscreenState();
}

class _ProfileInfoscreenState extends State<ProfileInfoscreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
 

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                child: profileHeadline(width: width),
              ),
              orgTable(),
              SizedBox(height: height*0.05,),
              Container( 
                     padding: const EdgeInsets.all(18),
                child:Column(
                children: [
                  chartHeadline(
                  height: height,
                  title: "Projects",
                  value: "30",
                  subtiltle: "done this month"),
                  SizedBox(height: height*0.01,),
                 projTable(height: height, width: width)


                ],
              ), 
              )

            ],
          ),
        ),
      ),
    );
  }

}





