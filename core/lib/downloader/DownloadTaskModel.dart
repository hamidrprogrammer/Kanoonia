
import 'package:core/downloader/DownloadTaskStrategyRepository.dart';

class DownloadTaskModel {
  DownloadTaskModel({
    required this.link,
    required this.type,
  });

  final String link;
  final DownloadTaskTypes type;
}
