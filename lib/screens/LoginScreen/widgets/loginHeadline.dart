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
    Text(
      "Welcome Back",
      style: Theme.of(context).textTheme.headlineLarge,
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
