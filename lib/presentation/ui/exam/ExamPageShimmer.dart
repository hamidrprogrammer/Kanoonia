import 'package:flutter/material.dart';

import '../../../common/imports/WidgetImports.dart';
import '../main/BaseShimmer.dart';

class ExamPageShimmer extends StatelessWidget {
  const ExamPageShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MySpacer(size: 20),
            Padding(
              padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.grey.shade100),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
