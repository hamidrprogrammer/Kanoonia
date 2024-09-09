import 'package:kanooniha/presentation/ui/messenger/MessengerPageUI.dart';

import '../../../common/imports/WidgetImports.dart';
import 'HomeNavigationModel.dart';

class MessagesNavigationModel extends HomeNavigationModel {
  String badgeContainer = '';

  MessagesNavigationModel() {
    badgeContainer = getBadge;
  }

  @override
  IconData icon() {
    return CupertinoIcons.chat_bubble_2_fill;
  }

  void changeBadge(String newBadge) {
    badgeContainer = newBadge;
  }

  @override
  String name = 'پیام ها';


  @override
  HomeNavigationEnum value() {
    return HomeNavigationEnum.messages;
  }

  @override
  String badge() {
    return badgeContainer;
  }

  @override
  Widget page() => const MessengerPageUI();

  @override
  String serverSideName() => 'Message';
}
