import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class MyRingTone{
  final FlutterRingtonePlayer _ringtonePlayer = FlutterRingtonePlayer();

  Future<void> play(){
    return _ringtonePlayer.playRingtone();
  }

  Future<void> stop(){
    return _ringtonePlayer.stop();
  }
}