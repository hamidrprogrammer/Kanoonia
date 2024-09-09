import 'package:flutter/foundation.dart';

class AppConfiguration {
  static const versionCode = 70;
  static const versionName = '70.0.5';
  static get extraHeaders => {
        'version': versionCode.toString(),
        'platform': kIsWeb ? 'WebApp' : 'Android',
        'appid': 'DF637BE4-121A-47D7-A317-E50CF52A298A'
      };
}
