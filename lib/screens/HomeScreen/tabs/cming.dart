import 'package:flutter/material.dart';

class Cming extends StatelessWidget {
  const Cming({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:  Center(child: Column(
        children: [
          SizedBox(height: 200,),
          Text('coming soon',style: Theme.of(context).textTheme.displayMedium,),
        ],
      ))
    );
  }
}