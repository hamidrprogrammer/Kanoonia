import 'dart:async';

import 'package:core/call/my_webrtc_impl.dart';
import 'package:core/call/user.dart';
import 'package:kanooniha/core/navigationService/NavigationService.dart';
import 'package:kanooniha/data/bases/baseViewModel.dart';

class CallViewModel extends BaseViewModel {
  AppState uiState = AppState.idle;
  final NavigationServiceImpl _navigationServiceImpl = GetIt.I.get();
  final MyWebRtcImpl _webRtcImpl = GetIt.I.get();
  int tick = 0;
  bool isSpeakerOn = false;

  User? user;

  CallViewModel(super.initialState) {
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
  String pageName() => 'call_page';

  void getExtra() {
    var data = _navigationServiceImpl.getArgs();
    if (data == null) {
      _navigationServiceImpl.pop();
      return;
    }
    Map<String, dynamic> datas = Map<String, dynamic>.from(data[0]);
    var userId = datas['userIdHash'];

    print('got data from call vm and data is \n $userId \n');
    user = User(
      userName: datas['username'].toString(),
      connectionId: datas['connectionId'].toString(),
      userId: datas['userIdHash'].toString(),
      officeId: datas['officeId'].toString(),
      isOffice: false,
      inCall: false,
    );

    print('got user ==========>\n ${user?.toMap()} \n');
    uiState = AppState.success(true);
    initTimer();
    refreshScreen();
  }

  void hangup(use) async {
    _navigationServiceImpl.pop();

    _webRtcImpl.signalR.hangUp();
    _webRtcImpl.closeAllConnection();
    _webRtcImpl.onDeclined(use);
    _webRtcImpl.signalR.decline(use);
  }

  void mute() {
    _webRtcImpl.muteMic();
    refreshScreen();
  }

  bool get isMute => _webRtcImpl.isMute;

  void changeSpeaker() {
    _webRtcImpl.turnSpeaker(!isSpeakerOn);
    isSpeakerOn = !isSpeakerOn;
    refreshScreen();
  }

  void initTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      tick = timer.tick;
      refreshScreen();
    });
  }
}
