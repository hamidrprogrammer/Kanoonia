import 'NetworkConsts.dart';

class MessengerApiRoutes{
  static const fetchAllMessagesList =
      '${NetworkConsts.BasePath}/FetchAllMessagesList';
  static const fetchUnreadedMessagesList =
      '${NetworkConsts.BasePath}/FetchUnreadedMessagesList';
  static const fetchUnreadedMessagesListForHomePage =
      '${NetworkConsts.BasePath}/FetchUnreadedMessagesList_ForHomePage';
  static const createMessageVisitLog =
      '${NetworkConsts.BasePath}/CreateMessageVisitLog';
}