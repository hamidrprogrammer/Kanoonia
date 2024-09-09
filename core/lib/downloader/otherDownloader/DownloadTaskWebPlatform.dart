import 'dart:html' as html;

import 'package:core/downloader/DownloadTaskModel.dart';
import 'package:core/downloader/DownloadTaskRepository.dart';
import 'package:core/downloader/DownloadTaskStrategyRepository.dart';
import 'package:url_launcher/url_launcher.dart';

void openUrlShared(DownloadTaskModel model) {
  DownloadTaskWebPlatform(model).run();
}

class DownloadTaskWebPlatform extends DownloadTaskRepository {
  DownloadTaskWebPlatform(super.model);

  @override
  void run() {
    if (model.type == DownloadTaskTypes.file) {
      download();
    } else {
      _launchUrl();
    }
  }

  Future<void> download() async {
    html.AnchorElement anchorElement = html.AnchorElement(href: model.link);
    anchorElement.download = model.link;
    anchorElement.click();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(model.link))) {
      throw Exception('Could not launch ${model.link}');
    }
  }
}
