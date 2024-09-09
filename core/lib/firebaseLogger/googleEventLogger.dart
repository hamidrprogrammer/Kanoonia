import 'dart:io';

import 'package:core/firebaseLogger/shared_google_logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class GoogleEventLogger {
  static void logFirebaseEvent(String name, Map<String, dynamic> data) {
    if (kIsWeb) {
      logEvent(name, data);
    } else {
      if (Platform.isAndroid) {
        logEvent(name, data);
      }
    }
  }
}
