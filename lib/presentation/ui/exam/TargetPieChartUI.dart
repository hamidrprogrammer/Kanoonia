import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kanooniha/core/color/ColorExtension.dart';

import '../../../data/serializer/exam/TargetItem.dart';

class TargetPieChartUI extends StatelessWidget {
  const TargetPieChartUI({Key? key, required this.data, required this.list})
      : super(key: key);
  final PieTouchData data;
  final List<TargetItem?>? list;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          pieTouchData: data,
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          // centerSpaceRadius: 80,
          sections: showingSections() ?? [],
        ),
      ),
    );
  }

  List<PieChartSectionData>? showingSections() {
    return list?.map((item) {
      const fontSize = 12.0;
      const radius = 80.0;
      return PieChartSectionData(
        color: item?.courseId?.digitsOf().getColor().withOpacity(.8),
        value: item?.targetPercent?.toDouble(),
        title: item?.targetIndex?.toString(),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w200,
          color: getFontColorForBackground(
              item?.courseId?.digitsOf().getColor() ?? Colors.white),
        ),
        borderSide: BorderSide(
          width: .5,
          color: Colors.grey.shade100,
        ),
      );
    }).toList();
  }

  Color getFontColorForBackground(Color background) {
    return (background.computeLuminance() > 0.179)
        ? Colors.black
        : Colors.white;
  }
}
