import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/presentation/ui/main/ui_extension.dart';
import 'package:lottie/lottie.dart';

class ImageLoader extends StatelessWidget {
  const ImageLoader({
    Key? key,
    required this.url,
    this.fitModel = BoxFit.fill,
    this.width = 200,
    this.height = 200,
  }) : super(key: key);
  final String url;
  final BoxFit fitModel;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (_, __) => Icon(Icons.wallpaper, color: Colors.grey.shade50),
      errorWidget: (_, __, exception) {
        return Icon(
          Icons.error,
          color: Colors.grey.shade50,
        );
      },
      fit: fitModel,
      width: width,
      height: height,
    );
  }
}

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget(
      {Key? key, required this.message, required this.onReloadClick,})
      : super(key: key);
  final String message;
  final Function() onReloadClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/error.json',
            repeat: false,
            alignment: Alignment.center,
            height: 150,
          ),
          Text(
            message.isBlank == true ? 'اطلاعاتی یافت نشد' : message,
            style: context.textTheme.titleMedium,
          ),
          8.dpv,
          ElevatedButton(onPressed: onReloadClick, child: const Text('تلاش مجدد'))
        ],
      ),
    );
  }
}
