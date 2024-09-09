import 'package:flutter/material.dart';

extension NumberExtension on num {
  Iterable<int> digitsOf() sync* {
    var number = toInt();
    do {
      yield number.remainder(10);
      number ~/= 10;
    } while (number != 0);
  }
}

extension ColorExtension on Iterable<int?> {
  Color getColor() {
    if (length < 3) return Colors.grey;
    var r = (elementAt(0) ?? 5) * 100;
    var g = (elementAt(1) ?? 4) * r/2;
    var b = (elementAt(2) ?? 6) * 100;
    return Color.fromRGBO(r, g.toInt(), b, 1);
  }

  List<int> getRgb() {
    if (length < 3) return [1,1,1];
    var r = (elementAt(0) ?? 5) * 100;
    var g = (elementAt(1) ?? 4) * r/2;
    var b = (elementAt(2) ?? 6) * 100;
    return [r,g.toInt(),b];
  }
}
