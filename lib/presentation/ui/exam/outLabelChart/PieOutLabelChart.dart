import 'package:flutter/material.dart';
import 'package:kanooniha/core/color/ColorExtension.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../data/serializer/exam/TargetItem.dart';

class PieOutsideLabelChart extends StatelessWidget {
  final List<TargetItem> items;

  const PieOutsideLabelChart({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      series: <CircularSeries<TargetItem, String>>[
        PieSeries(
          dataSource: items,
          xValueMapper: (datum, index) => datum.targetIndex?.toString(),
          yValueMapper: (datum, index) => datum.targetPercent?.toInt(),
          dataLabelMapper: (datum, index) => datum.targetIndex?.toString(),
          radius: '60%',
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelIntersectAction: LabelIntersectAction.shift,
            labelPosition: ChartDataLabelPosition.outside,
            connectorLineSettings: ConnectorLineSettings(
              type: ConnectorType.curve,
              length: '25%',
            ),
          ),
          pointColorMapper: (datum, index) =>
              datum.courseId?.digitsOf().getColor(),
          strokeColor: Colors.grey.shade50,
          strokeWidth: 1,
          enableTooltip: true,
        )
      ],
    );
  }
}
