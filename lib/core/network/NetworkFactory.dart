import 'package:core/network/kanoonHttp/KanoonHttp.dart';
import 'package:get_it/get_it.dart';
import 'package:kanooniha/common/appCommons/AppConfiguration.dart';

class NetworkFactory {
  static KanoonDio get createKanoonDio => KanoonDio(
        logEnable: false,
        extraHeaders: AppConfiguration.extraHeaders,
      );

  static KanoonHttp getKanoonHttp() {
    if (GetIt.I.isRegistered<KanoonDio>()) {
      return KanoonHttp(
        GetIt.I.get<KanoonDio>(),
      );
    } else {
      throw Exception(
          'Kanoon dio should be registered in get_it before the instance of kanoon http');
    }
  }
}
