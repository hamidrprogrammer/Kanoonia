import 'package:firebase_analytics_web/firebase_analytics_web.dart';

// class WebGoogleLogger {
Future<void> logEvent(String name, Map<String, dynamic> data) async {
  var isSupported = await FirebaseAnalyticsWeb().isSupported();
  if (!isSupported) {
    return;
  }
  return FirebaseAnalyticsWeb().logEvent(name: name, parameters: data);
}
// }
