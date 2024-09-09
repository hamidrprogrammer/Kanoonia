import 'package:flutter/material.dart';

import '../../../common/ui/WidgetSize.dart';

class InnerRowWidget extends StatelessWidget {
  const InnerRowWidget({Key? key, required this.child, required this.alignment})
      : super(key: key);
  final Widget child;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(vertical: WidgetSize.basePaddingSize),
          child: child,
        ),
      ],
    );
  }
}
