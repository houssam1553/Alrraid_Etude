import 'package:arraid/config/colors.dart';
import 'package:arraid/screens/HomeScreen/widgets/chartHeadline.dart';
import 'package:flutter/material.dart';

class EventsContainer extends StatelessWidget {
  const EventsContainer({
    super.key,
    required this.width,
    required this.height,
  } );

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
          chartHeadline(height: height,title:"Events",value :"4",subtiltle:"this week"),
                   SizedBox(height: height *0.009,), // Space b

         
       EventWidget(
        height: height,
          title: 'Team Meeting',
          subtitle: 'Wed, Sep 25, 2024 • 10:30 AM',
        ),
        EventWidget(
        height: height,

          title: 'Project Deadline',
          subtitle: 'Fri, Sep 27, 2024 • 05:00 PM',
        ),
        EventWidget(
        height: height,

          title: 'Doctor Appointment',
          subtitle: 'Mon, Sep 30, 2024 • 09:45 AM',
        ),
        EventWidget(
        height: height,
          
          title: 'Dinner with Friends',
          subtitle: 'Wed, Oct 2, 2024 • 07:30 PM',
        ),                  
        ],
      ),
    );
  }
}




//import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final double height;

  const EventWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                Icons.notifications,
                color: ColorManager.primary,
              ),
              SizedBox(height: height * 0.009),
              Container(
                width: 2.0,
                height: height * 0.06,
                color: Colors.grey,
              ),
            ],
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: ColorManager.greyText,
                  ),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
