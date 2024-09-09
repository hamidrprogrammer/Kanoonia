// ignore_for_file: file_names
import 'package:core/firebaseLogger/googleEventLogger.dart';
import 'package:core/storage/shared/LocalSessionImpl.dart';

import 'baseViewModel.dart';

export 'package:kanooniha/common/imports/viewModelExports.dart';
export 'package:kanooniha/core/flow/MyFlow.dart';
export 'package:kanooniha/core/messagingService/MessagingService.dart';
export 'package:kanooniha/domain/network/NetworkExtensions.dart';

abstract class BaseViewModel extends Cubit<AppState> {
  var messageService = GetIt.I.get<MessagingServiceImpl>();
  var session = GetIt.I.get<LocalSessionImpl>();

  final message = BehaviorSubject<String>();

  // final model = GetIt.I.get<BaseModel>();
  // final session = GetIt.I.get<SessionManager>();

  BaseViewModel(super.initialState);

  void updateState(AppState newSate) {
    emit.call(newSate);
  }

  void postResult(AppState appState) => updateState(appState);

  void postLoader() {
    if (isClosed) {
      return;
    }
    updateState(AppState.loading);
  }

  void postIdle({dynamic data}) {
    if (isClosed) {
      return;
    }
    updateState(AppState.idle);
  }

  void updateScreen({required double time}) {
    if (isClosed) {
      return;
    }
    updateState(AppState.fresh(time));
  }

  void postSuccess({dynamic data}) {
    if (isClosed) {
      return;
    }
    updateState(AppState.success(data));
  }

  MyFlow<AppState> get mainFlow => MyFlow(
        (mainState) {
          postResult(mainState);
          if (mainState.isFailed) {
            handleFailed(mainState);
          }
        },
      );

  void handleFailed(AppState appState) {
    if (appState.isFailed) {
      messageService.showSnackBar(appState.getErrorModel?.message ?? '');
    }
  }

  void refreshScreen() {
    updateScreen(time: DateTime.now().millisecond.toDouble());
  }

  String pageName();

  logEvent();

  onReloadClick();

  void logOnFireBase(String pageName) {
    GoogleEventLogger.logFirebaseEvent('page_view', {'page_title': pageName});
  }
}
