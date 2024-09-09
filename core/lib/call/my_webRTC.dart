import 'package:core/call/signalr_callback.dart';

abstract class MyWebRTC {
  void start(type, data);
  void dispose();
  Future<void> initMedia();
  void initOffer(partnerClientId, stream);
  void receivedSdpSignal(connection, partnerClientId, sdp, type);
  void receivedCandidateSignal(connection, partnerClientId, candidate);
}
