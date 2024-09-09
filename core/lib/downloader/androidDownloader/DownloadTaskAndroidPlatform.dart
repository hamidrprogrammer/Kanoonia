import 'package:core/downloader/DownloadTaskModel.dart';
import 'package:core/downloader/DownloadTaskRepository.dart';
import 'package:core/downloader/DownloadTaskStrategyRepository.dart';
import 'package:core/pathProvider/may_path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';

void openUrlShared(DownloadTaskModel model) {
  DownloadTaskAndroidPlatform(model).run();
}

class DownloadTaskAndroidPlatform extends DownloadTaskRepository {
  DownloadTaskAndroidPlatform(super.model);

  @override
  Future<void> run() async {
    if (model.type == DownloadTaskTypes.file) {
      downloadAndroidPlatform();
    } else {
      _launchUrl();
    }
  }

  Future<String?> downloadAndroidPlatform() async {
    final taskId = await FlutterDownloader.enqueue(
      requiresStorageNotLow: true,
      saveInPublicStorage: true,
      url: model.link,
      headers: {},
      // optional: header send with url (auth token etc)
      savedDir: await MyPathProvider.externalStorage ?? await MyPathProvider.tempStorage,
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );
    return taskId;
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(model.link),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch ${model.link}');
    }
  }
}
