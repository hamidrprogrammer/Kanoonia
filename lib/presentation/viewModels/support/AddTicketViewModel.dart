import 'package:flutter/material.dart';
import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:kanooniha/domain/useCase/support/new_support_kind_use_case.dart';

import '../../../domain/formState/support/AddTicketFormState.dart';
import '../../../domain/useCase/support/AddTicketUseCase.dart';

class AddTicketViewModel extends BaseViewModel {
  AddTicketViewModel(super.initialState) {
    getKinds();
    logEvent();
  }

  final TextEditingController bodyController = TextEditingController();

  final _navigationService = GetIt.I.get<NavigationServiceImpl>();

  var formKey = GlobalKey<FormState>();

  AppState kindsState = AppState.idle;
  AppState uiState = AppState.idle;

  AddTicketFormState addTicketFormState = AddTicketFormState();

  void getKinds() {
    NewSupportKindUseCase().invoke(
      flow: MyFlow(
        (appState) {
          kindsState = appState;
          refreshState();
        },
      ),
    );
  }

  Function() onClick() {
    return () {
      if (isValid) {
        if (addTicketFormState.kindId.isEmpty) {
          messageService.showSnackBar('نوع مشکل را انتخاب کنید');
          return;
        }
        AddTicketUseCase().invoke(
            flow: MyFlow(
              (appState) {
                uiState = appState;
                refreshState();
                if (appState.isSuccess) {
                  messageService.showSnackBar('پیغام با موفقیت ارسال شد');
                  Future.delayed(const Duration(seconds: 1)).then((value) {
                    _navigationService.replaceTo(AppRoutes.supportMessages);
                  });
                }
              },
            ),
            data: addTicketFormState.createBody());
      }
    };
  }

  bool get isValid => formKey.currentState?.validate() == true;

  Function(String) get onDescriptionChange =>
      (value) => addTicketFormState.body = value;

  Function(int?) onKindsChanged() {
    return (value) {
      if (value != null) {
        addTicketFormState.kindId = value.toString();
      }
    };
  }

  void refreshState() =>
      updateScreen(time: DateTime.now().millisecond.toDouble());

  @override
  String pageName() => 'addTicket';

  @override
  logEvent() {
    logOnFireBase(pageName());
  }

  @override
  onReloadClick() {
    getKinds();
  }
}
