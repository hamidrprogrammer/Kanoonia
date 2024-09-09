import 'NetworkConsts.dart';

class InboxApiRoutes {
  static const getInboxMessages = '${NetworkConsts.BasePath}/GetInboxMessages';
  static const setInboxSeen = '${NetworkConsts.BasePath}/SetInboxSeen';
  static const addActionToInboxItem = '${NetworkConsts.BasePath}/AddActionToInboxItem';
  static const getStaticParams = '${NetworkConsts.BasePath}/GetStaticParams';
}
