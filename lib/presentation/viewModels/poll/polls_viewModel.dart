import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/Logger.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/data/body/poll/set_poll.dart';
import 'package:kanooniha/data/serializer/poll/polls_response.dart';
import 'package:kanooniha/domain/useCase/poll/set_poll_use_case.dart';
import 'package:kanooniha/presentation/ui/dialog/SuccessPollDialog.dart';

class PollsViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();

  late PageController controller;
  int index = 0;

  PollsViewModel(super.initialState) {
    controller = PageController(initialPage: index);
    getExtra();
  }

  PollsResponse? pollsResponse;

  @override
  logEvent() {}

  @override
  onReloadClick() {}

  @override
  String pageName() => 'polls';

  void setPoll(
      Poll poll, String? option, String? optionIndex, List<String>? options) {
    SetPollBody setPollBody = SetPollBody(
      uniqueId: pollsResponse!.uniqueId!.toString(),
      pollDetailId: poll.pollDetailsId!.toString(),
      answer: option,
      selectedOption: optionIndex,
      checkedOptions: options,
    );

    print('options = ${setPollBody.toJson()}');
    SetPollUseCase().invoke(
      flow: MyFlow((appState) {
        if (appState.isSuccess) {
          if (index == (pollsResponse?.polls?.length ?? 1) - 1) {
            Get.dialog(const SuccessPollDialog()).then((value) {
              _navigationServiceImpl.off(AppRoutes.home);
            });
          } else {
            controller.nextPage(
              duration: const Duration(milliseconds: 10),
              curve: Curves.bounceIn,
            );
          }
        }
        mainFlow.emit(appState);
      }),
      data: setPollBody,
    );
  }

  void getExtra() {
    var data = _navigationServiceImpl.getArgs();
    if (data != null && data is PollsResponse) {
      Logger.d('data received');
      pollsResponse = data;
      // refreshScreen();
    }
  }
}
