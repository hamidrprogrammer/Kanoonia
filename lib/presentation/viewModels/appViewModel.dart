import 'dart:isolate';
import 'dart:ui';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:core/network/interceptor/AuthorizationInterceptor.dart';
import 'package:core/network/interceptor/RefreshTokenInterceptor.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/core/app/notification/notification_controller.dart';
import 'package:kanooniha/domain/di/appModule.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';
import 'package:kanooniha/domain/useCase/app/refresh_token_interceptor_use_case.dart';

class AppViewModel extends Cubit<AppState> {
  AppViewModel(super.initialState);

  // AppViewModel(super.initialState) {
  //   AwesomeNotifications().setListeners(
  //     onActionReceivedMethod: NotificationController.onActionReceivedMethod,
  //     onNotificationCreatedMethod:
  //         NotificationController.onNotificationCreatedMethod,
  //     onNotificationDisplayedMethod:
  //         NotificationController.onNotificationDisplayedMethod,
  //     onDismissActionReceivedMethod:
  //         NotificationController.onDismissActionReceivedMethod,
  //   );
  // }

  static Future<void> initAppModule() async {
    await AppModule().initModules();
    await initInterceptors();
  }

  static AppViewModel getInstance = AppViewModel(AppState.idle);

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  // @pragma('vm:entry-point')
  // static Future<void> firebaseMessagingBackgroundHandler(
  //     RemoteMessage message) async {
  //   // If you're going to use other Firebase services in the background, such as Firestore,
  //   // make sure you call `initializeApp` before using other Firebase services.
  //   await Firebase.initializeApp();
  // }

  static Future<bool> initInterceptors() async {
    GetIt.I
        .get<KanoonHttp>()
        .addInterceptor(GetIt.I.get<AuthorizationInterceptor>());
    GetIt.I
        .get<KanoonHttp>()
        .addInterceptor(GetIt.I.get<RefreshTokenInterceptor>());
    RefreshTokenInterceptorUseCase().invoke();

    return Future.value(true);
  }

  @override
  Future<void> close() {
    GetIt.I.get<Client>().close();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    FlutterDownloader.cancelAll();
    return super.close();
  }
}
