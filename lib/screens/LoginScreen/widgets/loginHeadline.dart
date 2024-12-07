import 'package:flutter/material.dart';

class loginHeadline extends StatelessWidget {
  const loginHeadline({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 160,
          child: Image.asset(
            'assets/images/arraidLogo.png',
            fit: BoxFit.cover,
          ),
        ),
         SizedBox(
    height:  height * 0.0105, ),
    Center(
      child: Text(
      
        "S’authentifier avec votre \ncompte Alrraid Pro",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize:20, ),
      ),
    ),
    SizedBox(
    height:  height * 0.0105, ),
    Text(
      "Enter your email and password to signin",
      style: Theme.of(context).textTheme.bodyMedium,
    ),]
    );
  }
}
