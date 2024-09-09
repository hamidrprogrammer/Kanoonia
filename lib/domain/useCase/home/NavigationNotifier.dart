import 'package:get_it/get_it.dart';

import '../../../core/Notification/MyNotification.dart';

class NavigationNotifier {
  static const messages = 'Messages';
  static const news = 'News';

  NavigationNotifier.notifyMessages(String value) {
    notify(messages, value);
  }

  NavigationNotifier.notifyNews(String value) {
    notify(news, value);
  }

  notify(String target, String value) {
    GetIt.I.get<MyNotification>().publish('HomeViewModel', {target: value});
  }
}
