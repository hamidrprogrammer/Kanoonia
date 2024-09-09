import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

import 'DownloadTaskModel.dart';

abstract class DownloadTaskStrategyRepository {
  final String link;

  DownloadTaskStrategyRepository(this.link);

  DownloadTaskTypes type();

  DownloadTaskPlatformSupportedType platformType() => getPlatformType();

  void run();

  DownloadTaskTypes get getDownloadTaskTypes => type();

  DownloadTaskPlatformSupportedType get getDownloadTaskPlatformSupportedType =>
      platformType();

  DownloadTaskModel get getModel =>
      DownloadTaskModel(type: getDownloadTaskTypes, link: link);
}

DownloadTaskPlatformSupportedType getPlatformType() {
  if (kIsWeb) return DownloadTaskPlatformSupportedType.web;
  if (Platform.isAndroid) return DownloadTaskPlatformSupportedType.android;
  return DownloadTaskPlatformSupportedType.other;
}

extension DownloadTaskData on String? {
  DownloadTaskTypes getType() {
    if (this == 'url') return DownloadTaskTypes.url;
    return DownloadTaskTypes.file;
  }
}

enum DownloadTaskTypes {
  url,
  file;
}

enum DownloadTaskPlatformSupportedType {
  android,
  web,
  other;
}
