import 'dart:html';

import 'package:core/storage/LocalSessionRepository.dart';

LocalSessionRepository getLocalSession() => WebLocalSessionImpl();

class WebLocalSessionImpl extends LocalSessionRepository {

  static const maxAge = 'max-age';
  static int get thirtyDay => 30 * 24 * 60 * 60;

  @override
  Future<bool> clearSession() {
    deleteAllCookies();
    return Future.value(true);
  }

  @override
  Future<String> getData(String key) async{
    var name = RegExp(r"(^| )" + key + r"=([^;]+)").firstMatch(document.cookie ?? '')?.group(2) ?? '';
    return Future.value(name);
  }

  @override
  Future<void> insertData(Map<String, String> data) async{
    for (var element in data.entries) {
      document.cookie = "${element.key}=${element.value}; $maxAge=$thirtyDay";
    }
  }

  void deleteAllCookies() {
    var cookies = document.cookie?.split(";");
    for (var i = 0; i < (cookies?.length ?? 0); i++) {
      var cookie = cookies?[i];
      var eqPos = cookie?.indexOf("=");
      var name = (eqPos ?? 0) > -1 ? cookie?.substring(0, eqPos) : cookie;
      document.cookie = "$name=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
    }
  }
}
