import 'package:flutter/material.dart';
import 'package:kanooniha/common/imports/WidgetImports.dart';
import 'package:kanooniha/presentation/ui/main/BaseShimmer.dart';

class InboxShimmer extends StatelessWidget {
  const InboxShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
        child: ListView.separated(
            padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
            itemBuilder: (context, index) {
              return Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.shade100,
                ),
              );
            },
            separatorBuilder: (context, index) => const MySpacer(size: 20),
            itemCount: 10));
  }
}
