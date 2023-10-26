import 'package:flutter/material.dart';


class MyBarrier extends StatelessWidget {


final size;

const MyBarrier({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/assets/barrier.png',
      fit: BoxFit.fill,
      width: 100,
      height: size,
    );
  }
}