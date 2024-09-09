import 'package:flutter/material.dart';
import 'package:kanooniha/common/ui/WidgetSize.dart';

import '../main/BaseShimmer.dart';

class GetWorkBookKindsShimmerUI extends StatelessWidget {
  const GetWorkBookKindsShimmerUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          Container(
          margin: const EdgeInsets.all(WidgetSize.pagePaddingSize),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey.shade200),
    ),
    Container(
    margin: const EdgeInsets.all(WidgetSize.pagePaddingSize),
    height: 50,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    color: Colors.grey.shade200),
    )
    ,
    ]
    ,
    )
    ,
    );
  }
}
