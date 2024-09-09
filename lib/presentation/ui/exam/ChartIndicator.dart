import 'package:flutter/material.dart';
import 'package:kanooniha/core/color/ColorExtension.dart';
import 'package:kanooniha/data/serializer/exam/TargetItem.dart';

class ChartIndicator extends StatelessWidget {
  const ChartIndicator({
    Key? key,
    required this.targetItem,
  }) : super(key: key);
  final TargetItem? targetItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        shape: BoxShape.rectangle,
        color: targetItem?.courseId?.digitsOf().getColor(),
      ),
      child: Text(
        targetItem?.courseName ?? '',
        style: TextStyle(
          fontSize: 10,
          color: getFontColorForBackground(
            targetItem?.courseId?.digitsOf().getColor() ?? Colors.white,
          ),
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Color getFontColorForBackground(Color background) {
    return (background.computeLuminance() > 0.179)
        ? Colors.black
        : Colors.white;
  }
}
