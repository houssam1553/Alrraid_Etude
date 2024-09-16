
import 'package:arraid/config/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class ComingSoon extends StatefulWidget {
  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: ColorManager.lightPrimary,

      body: Center(
        child: 
        Column(
          children: [
            SizedBox(height: 100,),
            Text(
              "Comming Soon ",
              style: TextStyle(fontSize: 30),
            ),
          //  IconButton(onPressed: AuthenticationRepository.instance.logoutUser, icon: Icon(Icons.logout_outlined,color: Colors.red,))

          ],
        ),
      ),
    );
  }
}
