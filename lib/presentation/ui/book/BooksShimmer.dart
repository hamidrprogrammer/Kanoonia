import 'package:flutter/material.dart';
import 'package:kanooniha/presentation/ui/main/BaseShimmer.dart';

class BooksShimmer extends StatelessWidget {
  const BooksShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseShimmer(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 200,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey.shade100),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
