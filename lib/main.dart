import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:core/call/signalr.dart';
import 'package:core/downloader/MyDownloader.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kanooniha/common/imports/appImports.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:core/call/user.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'package:kanooniha/data/bases/baseViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/itransport.dart';
import 'core/Logger.dart';
import 'core/flow/MyFlow.dart';
import 'data/body/user/UserInfoCallResponse.dart';
import 'domain/app/MyApp.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'domain/app/MyApp.dart';
import 'domain/useCase/user/GetUserCallInfoUseCase.dart';
// background_isolate.dart
import 'dart:async';
import 'dart:isolate';

final MethodChannel platformChannel = MethodChannel('app.channel.launcher');

Future<void> launchUrl(String url) async {
  try {
    final String result =
        await platformChannel.invokeMethod('launchURL', {"url": url});
    print('Result from Native: $result');
  } on PlatformException catch (e) {
    print('Error: ${e.message}');
  }
}

void main() async {
  Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('tokenJwt');
    print("Token retrieved: $token");
    return token ?? "null";
  }

  WidgetsFlutterBinding.ensureInitialized();

  await AppViewModel.initAppModule();

// aunchUrl("https://example.com");
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.grey.shade50,
    systemNavigationBarColor: Colors.grey.shade50,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  // setPathUrlStrategy();
  runApp(
    BlocBuilder(
      builder: (context, state) => const MyApp(),
      bloc: AppViewModel.getInstance,
    ),
  );
}


//
// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'my_foreground',
//     'MY FOREGROUND SERVICE',
//     description: 'This channel is used for important notifications.',
//     importance: Importance.low,
//   );
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   if (Platform.isIOS || Platform.isAndroid) {
//     await flutterLocalNotificationsPlugin.initialize(
//       const InitializationSettings(
//         iOS: DarwinInitializationSettings(),
//         android: AndroidInitializationSettings('ic_bg_service_small'),
//       ),
//     );
//   }
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStart,
//       autoStart: true,
//       isForegroundMode: true,
//       notificationChannelId: 'my_foreground',
//       initialNotificationTitle: 'AWESOME SERVICE',
//       initialNotificationContent: 'Initializing',
//       foregroundServiceNotificationId: 888,
//     ),
//     iosConfiguration: IosConfiguration(
//       autoStart: true,
//       onForeground: onStart,
//       onBackground: onIosBackground,
//     ),
//   );
// }
//
//
// Future<bool> onIosBackground(ServiceInstance service) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   DartPluginRegistrant.ensureInitialized();
//
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   await preferences.reload();
//   final log = preferences.getStringList('log') ?? <String>[];
//   log.add(DateTime.now().toIso8601String());
//   await preferences.setStringList('log', log);
//
//   return true;
// }

//
// void onStart(ServiceInstance service) async {
//   print("START");
//   DartPluginRegistrant.ensureInitialized();
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {
//         flutterLocalNotificationsPlugin.show(
//           888,
//           'COOL SERVICE',
//           'Awesome ${DateTime.now()}',
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               'my_foreground',
//               'MY FOREGROUND SERVICE',
//               icon: 'ic_bg_service_small',
//               ongoing: true,
//             ),
//           ),
//         );
//
//         service.setForegroundNotificationInfo(
//           title: "My App Service",
//           content: "Updated at ${DateTime.now()}",
//         );
//       }
//       HubConnection? hubConnection;
//       getAccessToken().then((accessToken) {
//         print("accessToken");
//         print(accessToken);
//         if (accessToken != "null") {
//
//
//           if(hubConnection.isNull){
//
//
//           print("HubConnectionNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
//
//
//           const serverUrl = "https://app.kanoon.ir/api/ConnectionHub";
//           final connectionOptions = HttpConnectionOptions(
//               transport: HttpTransportType.WebSockets,
//               logMessageContent: true,
//               requestTimeout: 30000,
//               accessTokenFactory: getAccessToken
//
//           );
//           hubConnection = HubConnectionBuilder()
//               .withUrl(serverUrl, options: connectionOptions)
//               .build();
//
//           hubConnection?.onclose(({error}) {
//             print('hubConnection closed error is ${error?.toString()}');
//           });
//           }
//           // Your code here
//         }
//       });
//
//     }
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userString = prefs.getString('userBack');
//     Map<String, dynamic> userMap = Map.from(json.decode(userString!));
//
//     final deviceInfo = DeviceInfoPlugin();
//     String? device;
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//       device = androidInfo.model;
//     }
//
//     if (Platform.isIOS) {
//       final iosInfo = await deviceInfo.iosInfo;
//       device = iosInfo.model;
//     }
//
//     service.invoke(
//       'update',
//       {
//         "current_date": DateTime.now().toIso8601String(),
//         "device": device,
//       },
//     );
//
//     // Send data to SignalR hub
//
//   });
// }
