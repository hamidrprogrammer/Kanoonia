import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/presentation/ui/main/MyLoader.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'ExamCourceResponse.dart';

class CourseRangePickerUI extends StatelessWidget {
  const CourseRangePickerUI({
    Key? key,
    this.course,
    required this.value,
    required this.state,
    required this.onClick,
    required this.onValueChange,
  }) : super(key: key);
  final Courses? course;
  final AppState state;
  final Function(int, double) onClick;
  final Function(dynamic) onValueChange;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: WidgetSize.pagePaddingSize),
      padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
      decoration: BoxDecoration(
          color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(course?.courseName ?? ''),
              Text(getTarazAsString()),
            ],
          ),
          SfSlider(
            value: value,
            onChanged: (newValue) {
              if (course?.preTarget != null) {
                course?.clearPreTarget();
              }
              onValueChange.call(newValue);
            },
            tooltipTextFormatterCallback: (actualValue, formattedText) {
              return getTarazAsString();
            },
            enableTooltip: true,
            tooltipShape: const SfPaddleTooltipShape(),
            min: 0,
            max: 10,
            interval: 1,
            showDividers: true,
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.isSuccess
                        ? Colors.green
                        : context.theme.primaryColor,
                  ),
                  onPressed: () {
                    onClick.call((value * 10).toInt(), getTaraz());
                  },
                  child: state.isLoading
                      ? const MyLoader()
                      : state.isSuccess
                      ? const Icon(CupertinoIcons.check_mark)
                      : const Text('ثبت')),
            ],
          )
        ],
      ),
    );
  }

  String getTarazAsString() {
    if (course?.preTarget != null) {
      return course!.preTarget!.targetIndex.toString();
    }
    return getTaraz().isInfinite ? '' : getTaraz().toInt().toString();
  }

  double getTaraz() {
    return (((1000 * (value - (course?.averagePercent?.toDouble() ?? 0))) /
        getSigma(course?.sigma)) +
        5000);
  }

  double getSigma(num? sigma) {
    if (sigma == null) return 1.0;
    if (sigma == 0) return 1.0;
    return sigma.toDouble();
  }
}

extension Ex on double {
  double toFixedDouble(int n) => double.parse(toStringAsFixed(n));
}
