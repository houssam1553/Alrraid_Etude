import 'package:arraid/config/colors.dart';
import 'package:arraid/screens/HomeScreen/widgets/chartHeadline.dart';
import 'package:flutter/material.dart';

class LineChartContainer extends StatelessWidget {
  const LineChartContainer({
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
          chartHeadline(height: height,title:"Views overview",value :"(+5%)",subtiltle:"in 2024"),
         
          Container(
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: chart),
        
                           
        ],
      ),
    );
  }
}




