
import 'package:arraid/screens/HomeScreen/charts/barChart.dart';
import 'package:arraid/screens/HomeScreen/charts/lineChart.dart';
import 'package:arraid/screens/HomeScreen/widgets/barChartContainer.dart';
import 'package:arraid/screens/HomeScreen/widgets/dashboardCard.dart';
import 'package:arraid/screens/HomeScreen/widgets/eventsContainer.dart';
import 'package:arraid/screens/HomeScreen/widgets/linearChartContiner.dart';
import 'package:arraid/screens/HomeScreen/widgets/projectsContainer.dart';

import 'package:flutter/material.dart';

class dashboardPage extends StatelessWidget {
  const dashboardPage({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
            SizedBox(height: height*0.015,),
          dashboardCard(
            width: width,
            title: "Today's users",
            value: "2,300",
            precentage: "+5%",
          ),
     
          SizedBox(height: height*0.015,),
          barchartContainer(width: width, height: height,chart: BarChartSample3(),),
          SizedBox(height: height*0.015,),
          LineChartContainer(width: width, height: height,chart: LineChartSample2(),),
           SizedBox(height: height*0.015,),
          ProjectsContainer(width: width, height: height,),
           SizedBox(height: height*0.015,),
    EventsContainer(width: width, height: height)
    
        ],
      ),
                        );
  }
}


