import 'dart:io' show Platform;

import 'package:core/downloader/DownloadTaskModel.dart';
import 'package:core/downloader/DownloadTaskStrategyRepository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:core/downloader/androidDownloader/DownloadTaskAndroidPlatform.dart'
if (dart.library.html) 'package:core/downloader/otherDownloader/DownloadTaskWebPlatform.dart';

class MyDownloader {
  static init() async{
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
      }
    }
  }

  static void openUrl({required String link, type = DownloadTaskTypes.url}) {
    var model = DownloadTaskModel(type: type, link: link);
    openUrlShared(model);
  }
}
