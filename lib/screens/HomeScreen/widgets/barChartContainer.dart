import 'package:arraid/config/colors.dart';
import 'package:arraid/screens/HomeScreen/widgets/chartHeadline.dart';
import 'package:arraid/screens/HomeScreen/widgets/userProgress.dart';
import 'package:flutter/material.dart';

class barchartContainer extends StatelessWidget {
  const barchartContainer({
    super.key,
    required this.width,
    required this.height, required this.chart,
  } );

final Widget chart;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.68,
      padding: EdgeInsets.symmetric(horizontal:  width*0.03,vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           chartHeadline(height: height,title:"Active Users",value :"(+23)",subtiltle:"Than last week"),
          SizedBox(
            height: height * 0.025,
          ),
          Container(
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: chart),
          SizedBox(
            height: height * 0.025,
          ),
         
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              usersProgress(width: width, height: height,title: "Users",value: "32,248", icon: Icons.person,),
               usersProgress(width: width, height: height,title: "Clicks",value: "6,765", icon: Icons.ads_click_outlined,)
    
            ],
          ),
                           
        ],
      ),
    );
  }
}
