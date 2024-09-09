import 'package:path_provider/path_provider.dart';


class MyPathProvider{
  static Future<String?> get externalStorage async => (await getExternalStorageDirectory())?.path;
  static Future<String> get tempStorage async => (await getTemporaryDirectory()).path;
}