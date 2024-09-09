import 'DownloadTaskModel.dart';

abstract class DownloadTaskRepository {
  DownloadTaskRepository(this.model);

  final DownloadTaskModel model;

  void run();
}
