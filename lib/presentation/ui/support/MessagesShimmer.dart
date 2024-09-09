import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:kanooniha/presentation/ui/main/BaseShimmer.dart';

import '../../../common/imports/WidgetImports.dart';

class MessagesShimmer extends StatelessWidget {
  const MessagesShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
        child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(WidgetSize.pagePaddingSize),
                child: Bubble(
                  color: Colors.grey.shade100,
                  nip: BubbleNip.rightTop,
                  child: const SizedBox(
                    height: 100,
                  ),
                ),
              );
            },
            itemCount: 10));
  }
}
