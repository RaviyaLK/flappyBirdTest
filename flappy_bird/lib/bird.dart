import 'package:flutter/material.dart';


class MyBird extends StatelessWidget {
  const MyBird({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.1,
      width: 60,
      child: Image.asset(
        'lib/assets/bird.png',
        ),
    );
  }
}