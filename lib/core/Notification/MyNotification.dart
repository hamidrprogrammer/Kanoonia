import 'package:get/get.dart';
import 'package:kanooniha/core/Logger.dart';
import 'package:kanooniha/core/Notification/MyNotificationListener.dart';

class MyNotification {
  final List<MyNotificationListener> notificationListener = [];

  void subscribeListener(MyNotificationListener newListener) {
    notificationListener.add(newListener);
  }

  void removeSubscribe(MyNotificationListener newListener) {
    notificationListener.remove(newListener);
  }

  void publish(String tag, dynamic data) {
    var listener = notificationListener.firstWhereOrNull((element) {
      Logger.d(element.tag());
      return element.tag() == tag;
    });
    if (listener != null) {
      listener.onReceiveData(data);
    }
  }
}
