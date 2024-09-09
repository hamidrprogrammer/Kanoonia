import 'package:flutter/material.dart';
import 'package:kanooniha/presentation/ui/main/BaseShimmer.dart';

import '../../../common/imports/WidgetImports.dart';

class TargetsShimmer extends StatelessWidget {
  const TargetsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
        child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey.shade100,
                  ),
                ),
              );
            },
            itemCount: 10));
  }
}
