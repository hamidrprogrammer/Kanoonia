import 'package:core/call/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/signalr_client.dart';

import 'signalR_state.dart';
import 'signalr_callback.dart';

class SignalR extends CallBack {
  List<SignalRState> stateCallbacks = [];
  static const platform = MethodChannel('ir.kanoon.kanooniha.android/messages');

  HubConnection? hubConnection;
  Future<String> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Assuming you have stored the token with the key 'accessToken'
    String? token = prefs.getString('tokenJwt');
    print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR");
    if (token != null) {
      return token;
    } else {
      throw Exception('Token not found');
    }
  }

  Future<void> initHubConfig(hubConnectionController) async {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      print(
          "${rec.level.name}: ${rec.time}: ${rec.message} ${rec.object != null ? '=>' : ''} ${rec.object ?? ''}");
    });

    hubConnectionController?.onclose(({error}) {
      print('hubConnection closed error is ${error?.toString()}');
    });
  }

  initEventsHandler(hubConnectionController) {
    hubConnectionController?.stateStream.listen(_handleEventStream);

    hubConnectionController?.on('CallUserList', _handleUpdateUserList);
    hubConnectionController?.on('CallIncoming', _handleIncomingCall);
    hubConnectionController?.on('CallDeclined', _handleCallDeclined);
    hubConnectionController?.on('ReceiveSignal', _handleReceiveSignal);
    hubConnectionController?.on('CallAccepted', _handleCallAccepted);
    hubConnectionController?.on('CallEnded', _handleCallEnded);
    hubConnectionController?.on(
        'SendNotificationToAll', _handleReceiveNotificationUser);
    hubConnectionController?.on(
        'SendNotificationToUser', _handleReceiveNotificationGrop);

    hubConnectionController?.on(
        'SendNotificationToGroup', _handleReceiveNotification);
  }

  void _handleCallDeclined(List<Object?>? arguments) {
    onMessage(MessageType.decline, arguments);
  }

  void _handleCallAccepted(List<Object?>? arguments) {
    onMessage(MessageType.accept, arguments);
  }

  void _handleCallEnded(List<Object?>? arguments) {
    onMessage(MessageType.callEnd, arguments);
  }

  void _handleReceiveNotificationUser(List<Object?>? arguments) {
    print("SendNotificationToUser");
    print(arguments);
    onMessage(MessageType.receiveNotification, arguments);
  }

  void _handleReceiveNotificationGrop(List<Object?>? arguments) {
    print("SendNotificationToGroup");
    print(arguments);
    onMessage(MessageType.receiveNotification, arguments);
  }

  void _handleReceiveNotification(List<Object?>? arguments) {
    print("SendNotificationToAll");
    print(arguments);
    onMessage(MessageType.receiveNotification, arguments);
  }

  void _handleReceiveSignal(List<Object?>? arguments) {
    onMessage(MessageType.signal, arguments);
  }

  void _handleIncomingCall(List<Object?>? arguments) {
    onMessage(MessageType.calling, arguments);
  }

  void _handleUpdateUserList(List<Object?>? arguments) {
    onMessage(MessageType.updateUsers, arguments);
  }

  void _handleEventStream(HubConnectionState event) {
    onMessage(MessageType.newState, event);
  }

  Future<void> hangUp() async {
    print('hanging up');
    try {
      await platform.invokeMethod('hangingUp');
    } catch (e) {
      print("Failed to send message: '$e'.");
    }
  }

  Future<Object?> answerCall(User user) {
    print("================> RUN void answerCall ");

    return sendMessage("AnswerCall", args: [true, user.userId, true]);
  }

  Future<void> decline(user) async {
    updateListeners((callBack) => callBack.onCallEndUser(user));
    // try {
    //   await platform.invokeMethod('sendMessage',
    //       {"methodName": "CallAnswerEnd", "message": user.userId});
    // } catch (e) {
    //   print("Failed to send message: '$e'.");
    // }
  }

  void callUser(dynamic user) {
    print("callUser=====================?>?:L");

  }

  @override
  onMessage(type, data) {
    print("onMessage====>" + type.toString());

    switch (type) {
      case "CallIncoming":
        updateListeners((callBack) => callBack.onNewCall(data));
        break;
      case "CallDeclined":
        updateListeners((callBack) => callBack.onDeclined(data));
        break;
      case "CallAccepted":
        updateListeners((callBack) => callBack.onAccept(data));
        break;
      case "receiveNotification":
        updateListeners((callBack) => callBack.onReceiveNotification(data));

        break;
      case "ReceiveSignal":
        updateListeners((callBack) => callBack.onNewSignal(data));

        break;
      case "CallUserList":
        updateListeners((callBack) => callBack.onNewUserList(data));
        break;
      case "CallEnded":
        updateListeners((callBack) => callBack.onCallEnd(data));
        break;
      case "newState":
        updateListeners((callBack) {
          callBack.onNewState(data);
          if (data is HubConnectionState &&
              data == HubConnectionState.Connected) {
            callBack.onConnected(data);
          }
        });
    }
  }

  updateListeners(Function(SignalRState callBack) callback) {
    for (var element in stateCallbacks) {
      callback.call(element);
    }
  }

  @override
  Future<Object?> sendMessage(String name, {List<Object>? args}) {
    return hubConnection!.invoke(name, args: args);
  }

  @override
  start(hubConnectionController) {
    initHubConfig(hubConnectionController);
    initEventsHandler(hubConnectionController);
    hubConnection?.start();
  }

  void addStateListener(SignalRState state) {
    stateCallbacks.add(state);
  }

  @override
  stop() {
    stateCallbacks.clear();
    hubConnection?.stop();
  }

  bool get isConnected => hubConnection?.state == HubConnectionState.Connected;
}
