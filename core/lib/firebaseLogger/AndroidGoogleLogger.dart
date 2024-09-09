import 'package:firebase_analytics/firebase_analytics.dart';

// class AndroidGoogleLogger {
Future<void> logEvent(String name, Map<String, dynamic> data) async {
  var isSupported = await FirebaseAnalytics.instance.isSupported();
  if (!isSupported) {
    return;
  }
  return FirebaseAnalytics.instance.logEvent(name: name, parameters: data);
}
// }
