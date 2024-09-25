
import 'package:arraid/screens/HomeScreen/charts/barChart.dart';
import 'package:arraid/screens/HomeScreen/charts/lineChart.dart';
import 'package:arraid/screens/HomeScreen/widgets/barChartContainer.dart';
import 'package:arraid/screens/HomeScreen/widgets/dashboardCard.dart';
import 'package:arraid/screens/HomeScreen/widgets/eventsContainer.dart';
import 'package:arraid/screens/HomeScreen/widgets/linearChartContiner.dart';
import 'package:arraid/screens/HomeScreen/widgets/projectsContainer.dart';
import 'package:arraid/screens/HomeScreen/widgets/usersContainer.dart';

import 'package:flutter/material.dart';

class usersPage extends StatelessWidget {
  const usersPage({
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
        UsersContainer(width: width, height: height)
    
        ],
      ),
                        );
  }
}


