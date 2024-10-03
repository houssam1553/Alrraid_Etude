import 'package:arraid/screens/HomeScreen/userMoreInfo/widgets/companyTableRow.dart';
import 'package:arraid/screens/HomeScreen/userMoreInfo/widgets/yesNoButton.dart';
import 'package:flutter/material.dart';

class orgTable extends StatelessWidget {
  const orgTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      
      border: TableBorder(
        horizontalInside: BorderSide(width: 1,
                color: Color(0xFFE2E8F0),),
      ),
                 columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      children: [
        // Table header with labels for each column
        TableRow(children: [
          Padding(
              padding: EdgeInsets.only(left:  18.0,bottom: 10),
            child: Text(
              'Website',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
     padding: EdgeInsets.only(right:  20.0,bottom: 10),
            child: Text(
              'Signed up',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
        ]),
        
        // Data rows
        TableRow(children: [
          companyTableRow(organization: "Alrraid PRO Etude", title: "Freelancer",),
          Padding(
             padding: EdgeInsets.only(right:  47.0,top: 10,bottom: 10),
           child: MyButton()
           )
        ]),
        // Additional empty rows
        TableRow(children: [
          companyTableRow(organization: "Alrraid PRO Freelance", title: "Freelancer",),
          Padding(
             padding: EdgeInsets.only(right:  47.0,top: 10,bottom: 10),
                 child: MyButton()
           )
        ]),   TableRow(children: [
          companyTableRow(organization: "Alrraid PRO Marketplace", title: "Freelancer",),
          Padding(
             padding: EdgeInsets.only(right:  47.0,top: 10,bottom: 10),
         child: MyButton()
           )
        ]),   TableRow(children: [
          companyTableRow(organization: "Alrraid PRO Academy", title: "Freelancer",),
          Padding(
             padding: EdgeInsets.only(right:  47.0,top: 10,bottom: 10),
    child: MyButton()
           )
        ]),
      ],
    );
  }
}