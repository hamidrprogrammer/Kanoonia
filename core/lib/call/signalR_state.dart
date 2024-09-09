abstract class SignalRState {
  void onNewCall(data);
  void onDeclined(data);
  void onAccept(data);
  void onNewSignal(data);
  void onReceiveNotification(data);
  void onNewUserList(data);
  void onCallEnd(data);
  void onCallEndUser(data);

  void onNewState(data);
  void onConnected(data);
  void onJoined(data);
}
