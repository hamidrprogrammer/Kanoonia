import 'package:get/get.dart';
import 'package:kanooniha/core/Logger.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';

import '../../../core/flow/MyFlow.dart';
import '../../../data/serializer/inbox/GetStaticParamsResponse.dart';
import '../../../data/serializer/messenger/FetchAllMessagesListResponse.dart';
import '../../../data/serializer/poll/CheckForPollResponse.dart';
import '../../../presentation/ui/dialog/StartUpDialogUI.dart';
import '../inbox/GetStaticParamsUseCase.dart';
import '../messenger/FetchAllMessagesListUseCase.dart';
import '../poll/CheckForPollUseCase.dart';
import 'NavigationNotifier.dart';

class StartupTaskUseCase {
  StartupTaskUseCase.invoke() {
    getPollAndMessengerData();

    getNewsBadgeData();
  }

  void getPollAndMessengerData() {
    CheckForPollUseCase().invoke(flow: MyFlow((state) {
      if (state.isSuccess && state.getData is CheckForPollResponse) {
        var response = state.getData as CheckForPollResponse;
        //get messages
        FetchAllMessagesListUseCase.initForAllUnreadMessages().invoke(
            flow: MyFlow((appState) async {
          if (appState.isSuccess &&
              appState.getData is FetchAllMessagesListResponse) {
            var data = appState.getData as FetchAllMessagesListResponse;
            if (data.data?.isNotEmpty == true) {
              NavigationNotifier.notifyMessages(data.data!.length.toString());
            }
            if (response.data?.pollUrl != null ||
                (data.data?.isNotEmpty == true && shouldShowDialog(data))) {
              if (Get.isDialogOpen == false) {
                Get.dialog(
                    StartupDialogUI(
                      response:
                          response.data?.pollUrl != null ? response : null,
                      count: data.data?.isNotEmpty == true
                          ? data.data?.length
                          : null,
                    ),
                    barrierDismissible: false);
              }
            }
          }
        }));
      }
    }));
  }

  void getNewsBadgeData() {
    GetStaticParamsUseCase().invoke(flow: MyFlow((appState) {
      if (appState.isSuccess && appState.getData is GetStaticParamsResponse) {
        GetStaticParamsResponse response = appState.getData;
        int count = response.data?.unSeenInboxCount?.toInt() ?? 0;
        NavigationNotifier.notifyNews(count > 0 ? count.toString() : '');
      }
    }));
  }

  bool shouldShowDialog(FetchAllMessagesListResponse data) {
    var unread =
        data.data!.firstWhereOrNull((element) => element.messageKind == 2);
    Logger.d('Unread is ${unread?.message}');
    return unread != null;
  }
}
