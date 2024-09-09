import 'package:flutter/material.dart';

class PlaceHolder extends StatelessWidget {
  const PlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      color: Colors.grey.shade50,
      strokeWidth: 2.0,
    );
  }
}
