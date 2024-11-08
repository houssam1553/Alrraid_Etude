import 'package:arraid/controllers/teamController.dart';
import 'package:arraid/controllers/usersController.dart';
import 'package:arraid/screens/HomeScreen/charts/barChart.dart';
import 'package:arraid/screens/HomeScreen/charts/lineChart.dart';
import 'package:arraid/screens/HomeScreen/widgets/barChartContainer.dart';
import 'package:arraid/screens/HomeScreen/widgets/dashboardCard.dart';
import 'package:arraid/screens/HomeScreen/widgets/eventsContainer.dart';
import 'package:arraid/screens/HomeScreen/widgets/linearChartContiner.dart';
import 'package:arraid/screens/HomeScreen/widgets/projectsContainer.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class dashboardPage extends StatefulWidget {
  const dashboardPage({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<dashboardPage> {  
  
  UserController userController = Get.find<UserController>();
  TeamController teamController = Get.find<TeamController>();

  bool _isChecking = true;
   @override
  void initState() {
    super.initState();
//userController.loadUsers();
    // Start the snackbar close check loop after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSnackbarCheckLoop();
    });
  }

  // Function to continuously check for open snackbars and close them
  void _startSnackbarCheckLoop() {
    _closeSnackbarsRecursively();
  }

  // Recursively check and close snackbars with a delay
  void _closeSnackbarsRecursively() {
    Future.delayed(Duration(milliseconds: 1), () {
      if (!_isChecking) return;

      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
        print('Snackbar closed');
      }

      // Continue the loop
      _closeSnackbarsRecursively();
    });
  }

  @override
  void dispose() {
    // Stop the loop when the widget is disposed
    _isChecking = false;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: widget.height * 0.015),
       Obx((){  return    dashboardCard(
            width: widget.width,
            title: "Today's users",
            value: userController.userCount.value.toString(),
            precentage: "+4%",
          );}),
          SizedBox(height: widget.height * 0.015),
          BarchartContainer(
            width: widget.width,
            height: widget.height,
            teamCount : teamController.teamCount.value.toString(),
       userCount:     userController.userCount.value.toString(),
            chart: BarChartSample3(),
          ),
          SizedBox(height: widget.height * 0.015),
          LineChartContainer(
            width: widget.width,
            height: widget.height,
            chart: LineChartSample2(),
          ),
          SizedBox(height: widget.height * 0.015),
          ProjectsContainer(
            width: widget.width,
            height: widget.height,
          ),
          SizedBox(height: widget.height * 0.015),
          EventsContainer(
            width: widget.width,
            height: widget.height,
          ),
        ],
      ),
    );
  }
}
