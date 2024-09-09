import 'package:flutter/material.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';

import '../main/BaseShimmer.dart';

class ExamShimmer extends StatelessWidget {
  const ExamShimmer({Key? key}) : super(key: key);

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
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade100),
            ),
            const MySpacer(size: 30),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade100),
            ),
            const MySpacer(),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade100),
            ),
            const MySpacer(),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade100),
            ),
            // const MySpacer(size: 20),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //       color: Colors.grey.shade100, shape: BoxShape.circle),
            // ),
          ],
        ),
      ),
    );
  }
}
