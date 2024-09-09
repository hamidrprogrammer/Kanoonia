import 'signalR_state.dart';

class MySignalRCallback extends SignalRState {
  @override
  void onAccept(data) {
    // TODO: implement onAccept
  }
  @override
  void onReceiveNotification(data) {
    print(data);
  }

  @override
  void onCallEnd(data) {
    // TODO: implement onCallEnd
  }

  @override
  void onDeclined(data) {
    // TODO: implement onDeclined
  }

  @override
  void onNewCall(data) {
    // TODO: implement onNewCall
  }

  @override
  void onNewSignal(data) {
    // TODO: implement onNewSignal
  }

  @override
  void onNewState(data) {
    // TODO: implement onNewState
  }

  @override
  void onNewUserList(data) {
    // TODO: implement onNewUserList
  }

  @override
  void onConnected(data) {
    // TODO: implement onConnected
  }

  @override
  void onJoined(data) {
    // TODO: implement onJoined
  }

  @override
  void onCallEndUser(data) {
    // TODO: implement onCallEndUser
  }
}
