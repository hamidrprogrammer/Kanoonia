import 'package:flutter/material.dart';

import '../../../common/ui/WidgetSize.dart';
import '../main/BaseShimmer.dart';
import '../main/Spacer.dart';

class TargetPageShimmer extends StatelessWidget {
  const TargetPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Padding(
        padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
        child: Column(
          children: [
            const MySpacer(size: 30),
            Container(
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade100),
            ),
            const MySpacer(size: 10),
            Container(
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade100),
            ),
            const MySpacer(size: 10),
            Container(
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade100),
            ),
            const MySpacer(size: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100, shape: BoxShape.circle),
            ),
          ],
        ),
      ),
    );
  }
}
