import 'package:flutter/material.dart';

import '../../../common/ui/WidgetSize.dart';
import '../main/BaseShimmer.dart';
import '../main/Spacer.dart';

class ExamDetailShimmer extends StatelessWidget {
  const ExamDetailShimmer({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Padding(
        padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 100,
                      height: 20.0,
                      color: Colors.grey.shade200,
                    ),
                    const MySpacer(size: 20),
                    Container(
                      width: 100,
                      height: 20.0,
                      color: Colors.grey.shade200,
                    ),
                    const MySpacer(size: 20),
                    Container(
                      width: 100,
                      height: 20.0,
                      color: Colors.grey.shade200,
                    ),
                  ],
                ),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                )
              ],
            ),
            const MySpacer(size: 30),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade100),
            ),
            const MySpacer(),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade100),
            ),
            const MySpacer(),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade100),
            ),
          ],
        ),
      ),
    );
  }
}
