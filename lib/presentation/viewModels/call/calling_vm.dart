import 'package:core/call/my_webrtc_impl.dart';
import 'package:core/call/user.dart';
import 'package:flutter/services.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';

class CallingViewModel extends BaseViewModel {
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  final MyWebRtcImpl _webRtcImpl = GetIt.I.get();

  User? user;

  CallingViewModel(super.initialState) {
    getExtra();
  }

  @override
  logEvent() {
    //
  }

  @override
  onReloadClick() {
    //
  }

  @override
  String pageName() => 'calling';

  void getExtra() {
    var data = _navigationServiceImpl.getArgs();
    print('got data from data is \n $data \n');
    if (data == null) {
      _navigationServiceImpl.pop();
      return;
    }

    var args = data;
    if (args == null || args.isEmpty) {
      _navigationServiceImpl.pop();
      return;
    }

    try {
      user = User(
        userName: args['username'] ?? 'default_username',
        connectionId: args['connectionId'] ?? 'default_connectionId',
        userId: args['userIdHash'] ?? 'default_userIdHash',
        officeId: args['officeId'] ?? 'default_officeId',
        isOffice: false,
        inCall: false,
      );

      print('got user from calling vm and data is \n ${user?.toMap()} \n');
      refreshScreen();
    } catch (e) {
      print('Error creating User: $e');
      _navigationServiceImpl.pop(); // Handle error case
    }
  }

  void accept() {
    print("================> RUN void accept ");
  }

  void decline(use) {
    const platform = MethodChannel('ir.kanoon.kanooniha.android/messages');

    _webRtcImpl.signalR.hangUp();
    _webRtcImpl.closeAllConnection();
    _webRtcImpl.onDeclined(use);
    _webRtcImpl.signalR.decline(use);
  }
}
