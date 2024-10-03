import 'package:arraid/config/colors.dart';
import 'package:flutter/material.dart';

class projTable extends StatelessWidget {
  const projTable({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    
  TableRow tableRow(double height, double width,String imageSource,String project,String budget, String precentage,double value) {
    return TableRow(children: [
        Padding(
           padding: EdgeInsets.only(top: 10,bottom: 10),
         child: 
          Row(
      children: [
        SizedBox(
          height: 25,
          width: 25,
          child: Image.asset(
          imageSource,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
        project,
          style: TextStyle(
            fontSize: 12,
            color: ColorManager.primary,
          ), // First text style
        ),
      ],
    ),),
        Padding(
           padding: EdgeInsets.only(top: 13,bottom: 13),
         child:  Text(
        budget,
          style: TextStyle(
            fontSize: 12,
            color: ColorManager.primary,
          ), // First text style
        ),
         ),
          Padding(
           padding: EdgeInsets.only(top: 10,bottom: 10),
         child: Column(children: [
            Text(
      precentage,
      style: TextStyle(
        fontSize: 12,
        color: ColorManager.primary,
      ), // First text style
    ),
    SizedBox(
      height: height * 0.007,
    ),
    SizedBox(width: width*0.15, child: LinearProgressIndicator(value: value,borderRadius: BorderRadius.circular(10),backgroundColor: Color(0xFFE2E8F0),color: ColorManager.primary,))
         ],)
         )
      ]);
  }
    return Table(
             
             border: TableBorder(
               horizontalInside: BorderSide(width: 1,
                       color: Color(0xFFE2E8F0),),
             ),
                        columnWidths: {
               0: FlexColumnWidth(3),
               1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
             },
             children: [
               // Table header with labels for each column
               TableRow(children: [
                 Padding(
                     padding: EdgeInsets.only(left:  28.0,bottom: 10),
                   child: Text(
                     'Project',
                     style: TextStyle(fontWeight: FontWeight.bold),
                     textAlign: TextAlign.left,
                   ),
                 ),
                 Padding(
            padding: EdgeInsets.only(bottom: 10),
                   child: Text(
                     'BUDGET',
                     style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
                     textAlign: TextAlign.left,
                   ),
                 ),
                    Padding(
            padding: EdgeInsets.only(bottom: 10),
                   child: Text(
                     'State',
                     style: TextStyle(fontWeight: FontWeight.bold),
                     textAlign: TextAlign.left,
                   ),
                 ),
               ]),
               
               // Data rows
               
              
               tableRow(height, width, "assets/images/proIcon1.png", "Conception d'une maison", "3000\$",  "100%",1),
               tableRow(height, width, "assets/images/proIcon2.png", "Realisation 100 logs", "1300\$",  "65&",0.65),
               tableRow(height, width, "assets/images/proIcon3.png", "Traitment 360", "3200\$",  "40%",0.4),
               tableRow(height, width, "assets/images/proIcon4.png", "Exterieur maison", "2600\$",  "10%",0.1),
       
              
          
             ],
           
     );
  }
}
