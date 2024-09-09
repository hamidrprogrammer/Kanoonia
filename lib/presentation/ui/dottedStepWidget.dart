import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/ui/WidgetSize.dart';

class DottedStepsWidget extends StatelessWidget {
  const DottedStepsWidget({
    Key? key,
    required this.widgets,
    this.dotSize = 20,
  }) : super(key: key);
  final List<Widget> widgets;
  final double dotSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: widgets
              .map((widget) => DottedDetailWidget(
                    widget: widget,
                    dotSize: dotSize,
                  ))
              .toList(),
        ),
        const LineSteps(
          size: 20,
        ),
      ],
    );
  }
}

class LineSteps extends StatelessWidget {
  const LineSteps({
    Key? key,
    this.color = Colors.grey,
    this.size = 20,
  }) : super(key: key);
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, size / 2, 0),
      height: 30,
      width: 2,
      decoration: BoxDecoration(
        color: color.withOpacity(.5),
        borderRadius: BorderRadius.circular(WidgetSize.baseRadiusSize),
      ),
    );
  }
}

class DotSteps extends StatelessWidget {
  const DotSteps({Key? key, this.size = 20}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.theme.primaryColor,
      ),
    );
  }
}

class DottedDetailWidget extends StatelessWidget {
  const DottedDetailWidget({
    Key? key,
    required this.widget,
    this.dotSize = 20,
  }) : super(key: key);
  final Widget widget;
  final double dotSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LineSteps(
          size: dotSize,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DotSteps(
              size: dotSize,
            ),
            const SizedBox(
              width: 5,
            ),
            widget
          ],
        ),
      ],
    );
  }
}
