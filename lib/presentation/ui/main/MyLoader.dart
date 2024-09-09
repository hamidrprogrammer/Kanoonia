import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLoader extends StatelessWidget {
  const MyLoader({Key? key, this.color = Colors.white, this.radius = 8})
      : super(key: key);
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: color,
      radius: radius,
    );
  }
}
