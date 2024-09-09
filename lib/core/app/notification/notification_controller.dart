// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kanooniha/common/appCommons/appRoutes.dart';
// import 'package:kanooniha/common/user/UserSessionConst.dart';
// import 'package:kanooniha/domain/useCase/BaseUseCase.dart';
//
// class NotificationController {
//   /// Use this method to detect when a new notification or a schedule is created
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }
//
//   /// Use this method to detect every time that a new notification is displayed
//   @pragma("vm:entry-point")
//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     // Your code goes here
//   }
//
//   /// Use this method to detect if the user dismissed a notification
//   @pragma("vm:entry-point")
//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     // Your code goes here
//   }
//
//   /// Use this method to detect when the user taps on a notification or action button
//   @pragma("vm:entry-point")
//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedAction) async {
//     // Your code goes here
//     Get.offAllNamed(AppRoutes.call, arguments: receivedAction);
//   }
//
//
//
//   @pragma("vm:entry-point")
//   static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
//     print('"SilentData": ${silentData.toString()}');
//     if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
//       showNotificationWithActions(silentData);
//       print("bg");
//     } else {
//       print("FOREGROUND");
//     }
//   }
//
//
//
//
//
//
//   /// Use this method to detect when a new fcm token is received
//   @pragma("vm:entry-point")
//   static Future<void> myFcmTokenHandle(String token) async {
//     LocalSessionImpl().insertData({UserSessionConst.firebaseToken:token});
//     debugPrint('FCM Token:"$token"');
//   }
//
//   /// Use this method to detect when a new native token is received
//   @pragma("vm:entry-point")
//   static Future<void> myNativeTokenHandle(String token) async {
//     debugPrint('Native Token:"$token"');
//   }
// }
