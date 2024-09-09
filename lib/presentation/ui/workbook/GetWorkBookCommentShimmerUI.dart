import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:kanooniha/common/ui/WidgetSize.dart';
import 'package:kanooniha/presentation/ui/main/BaseShimmer.dart';

class GetWorkBookCommentShimmerUI extends StatelessWidget {
  const GetWorkBookCommentShimmerUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: Padding(
        padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
        child: Bubble(
          color: Colors.grey.shade100,
          nip: BubbleNip.rightTop,
          child: const SizedBox(height: 100,),
        ),
      ),
    );
  }
}
