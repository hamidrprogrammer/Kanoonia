import 'package:kanooniha/common/network/NetworkConsts.dart';

class UriCreator {
  static Uri createUri({String? path, Map<String, dynamic>? body}) {
    return Uri.https(NetworkConsts.BaseUrl, path ?? '', body);
  }

  static Uri createUriWithUrl({String? url,String? path, Map<String, dynamic>? body}) {
    return Uri.https(url ?? '', path ?? '', body);
  }
}
