import 'package:core/call/my_webrtc_impl.dart';
import 'package:core/call/signalr.dart';
import 'package:core/network/interceptor/AuthorizationInterceptor.dart';
import 'package:core/network/interceptor/RefreshTokenInterceptor.dart';
import 'package:core/network/kanoonHttp/KanoonHttp.dart';
import 'package:core/ringtone/my_ringtone.dart';
import 'package:core/storage/shared/LocalSessionImpl.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kanooniha/common/appCommons/appRoutes.dart';
import 'package:kanooniha/core/network/NetworkFactory.dart';

import '../../core/Notification/MyNotification.dart';
import '../../core/messagingService/MessagingService.dart';
import '../../core/navigationService/NavigationService.dart';

class AppModule {
  var getIt = GetIt.instance;

  Future<bool> initModules() async {
    getIt.registerSingleton<RouteObserver>(RouteObserver());
    var navigationService =
        getIt.registerSingleton<NavigationServiceImpl>(NavigationServiceImpl());
    getIt.registerSingleton<MessagingServiceImpl>(MessagingServiceImpl());
    getIt.registerSingleton<LocalSessionImpl>(LocalSessionImpl());
    getIt.registerSingleton<MyNotification>(MyNotification());
    getIt.registerSingleton<KanoonDio>(NetworkFactory.createKanoonDio);
    var kanoon =
        getIt.registerSingleton<KanoonHttp>(NetworkFactory.getKanoonHttp());
    getIt.registerSingleton<AuthorizationInterceptor>(
      AuthorizationInterceptor(token: ''),
    );
    getIt.registerSingleton<RefreshTokenInterceptor>(
      RefreshTokenInterceptor(
        api: kanoon,
        failedFunc: () {
          navigationService.off(AppRoutes.login);
        },
      ),
    );
    getIt.registerSingleton(MyRingTone());
    initCallModule();
    return Future.value(true);
  }

  Future<void> initCallModule() async {
    var s = getIt.registerSingleton(SignalR());
    getIt.registerSingleton(MyWebRtcImpl(s));
  }
}
