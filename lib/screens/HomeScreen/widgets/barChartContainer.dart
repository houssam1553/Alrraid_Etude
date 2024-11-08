import 'package:arraid/config/colors.dart';
import 'package:arraid/screens/HomeScreen/widgets/chartHeadline.dart';
import 'package:arraid/screens/HomeScreen/widgets/userProgress.dart';
import 'package:flutter/material.dart';

class BarchartContainer extends StatefulWidget {
  const BarchartContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.chart,
    required this.userCount, 
    required this.teamCount, 

 
  }) : super(key: key);

  final Widget chart;
  final double width;
  final double height;
  final String userCount;
  final String teamCount;


  @override
  _BarchartContainerState createState() => _BarchartContainerState();
}

class _BarchartContainerState extends State<BarchartContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * 0.68,
      padding: EdgeInsets.symmetric(horizontal: widget.width * 0.03, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chartHeadline(
            height: widget.height,
            title: "Active Users",
            value: "(+${widget.userCount})",
            subtiltle: "Than last week",
          ),
          SizedBox(
            height: widget.height * 0.025,
          ),
          Container(
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: widget.chart,
          ),
          SizedBox(
            height: widget.height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              usersProgress(
                width: widget.width,
                height: widget.height,
                title: "Users",
                value: widget.userCount,
                icon: Icons.person,
              ),
              usersProgress(
                width: widget.width,
                height: widget.height,
                title: "Team",
                value: widget.teamCount,
                icon: Icons.work,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
