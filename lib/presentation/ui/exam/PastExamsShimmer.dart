import 'package:flutter/material.dart';
import 'package:kanooniha/presentation/ui/main/BaseShimmer.dart';

class PastExamsShimmer extends StatelessWidget {
  const PastExamsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
        child: GridView.builder(
      shrinkWrap: true,
      itemCount: 12,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisExtent: 200),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(16),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.grey.shade100),
        );
      },
    ));
  }
}
