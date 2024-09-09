import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:signalr_netcore/hub_connection.dart';

import 'my_webRTC.dart';
import 'signalR_state.dart';
import 'signalr.dart';
import 'user.dart';

class MyWebRtcImpl implements MyWebRTC, SignalRState {
  final SignalR signalR;
  User? user;
  static const platform = MethodChannel('ir.kanoon.kanooniha.android/messages');

  MyWebRtcImpl(this.signalR) {
    signalR.addStateListener(this);
  }

  Map<String, RTCPeerConnection> connections = {};
  MediaStream? localeStream;
  var peerConnectionConfig = {
    "iceServers": [
      {
        "urls": "stun:stun.relay.metered.ca:80",
      },
      {
        "urls": "turn:a.relay.metered.ca:80",
        "username": "a79ed1cf48006d9a273abd28",
        "credential": "fhXaHGiPxiaJFes4",
      }
    ]
  };
  final Map<String, dynamic> _config = {
    'mandatory': {},
    'optional': [
      {'DtlsSrtpKeyAgreement': true},
    ]
  };

  String get sdpSemantics => 'unified-plan';

  void setUser(User user) {
    this.user = user;
  }

  @override
  Future<void> initMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': false
    };

    localeStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    if (!kIsWeb) {
      localeStream?.getAudioTracks()[0].enableSpeakerphone(false);
    }
  }

  @override
  void initOffer(userId, stream) async {
    var connection = await getConnection(userId);
    print('Stream initOffer, initOffer');
    if (stream == null) {
      print('Stream is null, cannot create offer');
      return;
    }
    stream?.getTracks().forEach((track) {
      connection.addTrack(track, localeStream!);
    });

    connection.createOffer().then((offer) {
      connection.setLocalDescription(offer).then((value) async {
        var ld = await connection.getLocalDescription();
        print(
            "========================>SDP_____________++++++++++++++++SSSSSSSSSSSS");
        await platform.invokeMethod('sendSignal', {
          "sdp": jsonEncode({"candidate": ld?.toMap()}).toString(),
          "user": userId.toString()
        });
        print(
            "========================>SDP_____________++++++++++++++++SSSSSSSSSSSS");
        // service.invoke('sendSignal', {
        //   "sdp": jsonEncode({"sdp": ld?.toMap()}),
        //   "user": userId.toString()
        // });
      }).catchError((error) {
        print(error);
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void receivedCandidateSignal(connection, userId, candidate) {
    print('received new candidate and that is ${candidate}');
    try {
      connection.addCandidate(RTCIceCandidate(candidate['candidate'],
          candidate['sdpMid'], candidate['sdpMLineIndex']));
    } on Exception catch (e, s) {
      print(s);
    }
  }

  @override
  void receivedSdpSignal(connection, userId, sdp, type) async {
    var remoteDescription = RTCSessionDescription(sdp, type);
    final Map<String, dynamic> mediaConstraints = {
      'audio': true, // We want audio
      'video': false // We don't want video
    };
    try {
      // Request access to the user's audio stream
      MediaStream stream =
          await navigator.mediaDevices.getUserMedia(mediaConstraints);

      // Assign the stream to localeStream
      // localeStream = stream;
      // localeStream!.getAudioTracks()[0].enabled = false;

      // At this point, localeStream contains the audio stream
      // You can use it in your WebRTC connection
    } catch (e) {
      // Handle any errors that occur during stream acquisition
      print('Failed to access audio stream: $e');
    }
    if (remoteDescription.type == 'offer') {
      if (localeStream == null) {
        print("++++++++++++++++++++++++++++++>localeStream");
      }
      localeStream?.getTracks().forEach((track) {
        connection.addTrack(track, localeStream!);
      });

      // Set the remote description
      await connection.setRemoteDescription(remoteDescription);

      // Create an answer
      RTCSessionDescription? answer = await connection.createAnswer();

      // Set the local descriptions
      await connection.setLocalDescription(answer);

      // Send the answer
      var ld = await connection.getLocalDescription();
      print("Sending answer...");
      print(
          "========================>SDP_____________++++++++++++++++SSSSSSSSSSSS");
      await platform.invokeMethod('sendSignal', {
        "sdp": jsonEncode({"sdp": ld?.toMap()}).toString(),
        "user": userId.toString()
      });
      print(
          "========================>SDP_____________++++++++++++++++SSSSSSSSSSSS");
      // service.invoke('sendSignal', {
      //   "sdp": jsonEncode({"sdp": ld?.toMap()}),
      //   "user": userId.toString()
      // });
    } else if (remoteDescription.type == 'answer') {
      // Set the remote description directly
      await connection.setRemoteDescription(remoteDescription);
      print('WebRTC: remote Description type answers');
    }
  }

  @override
  void dispose() {
    localeStream?.dispose();
    connections.clear();
    signalR.stop();
  }

  @override
  void start(type, data) {
    print("onMessage=================>");
    signalR.onMessage(type, data);
  }

  Future<RTCPeerConnection> getConnection(userId) async {
    print("getConnection======================>");
    print(connections);
    if (connections[userId] != null) {
      return connections[userId]!;
    } else {
      return await initializeConnection(userId);
    }
  }

  Future<RTCPeerConnection> initializeConnection(dynamic userId) async {
    await initMedia();
    RTCPeerConnection connection = await createPeerConnection({
      ...peerConnectionConfig,
      ...{'sdpSemantics': sdpSemantics}
    }, _config);

    switch (sdpSemantics) {
      case 'plan-b':
        await connection.addStream(localeStream!);
        break;
      case 'unified-plan':
        localeStream!.getTracks().forEach((track) async {
          connection.addTrack(track, localeStream!);
        });
        break;
    }

    connection.onIceCandidate = (candidate) async {
      print('candidate is ${candidate.toMap()}');
      print(
          "========================>SDP_____________++++++++++++++++SSSSSSSSSSSS");
      await platform.invokeMethod('sendSignal', {
        "sdp": jsonEncode({"candidate": candidate?.toMap()}).toString(),
        "user": userId.toString()
      });
      print(
          "========================>SDP_____________++++++++++++++++SSSSSSSSSSSS");
      // service.invoke('sendSignal', {
      //   "sdp": jsonEncode({"candidate": candidate.toMap()}),
      //   "user": userId.toString()
      // });
    };

    connection.onRemoveTrack = (stream, track) {
      print('new onRemoveTrack');
    };
    connection.onAddTrack = (stream, track) {
      print('new onAddTrack state');
    };

    connection.onRemoveStream = (MediaStream stream) {
      print('new --stream--     removed!');
    };

    connection.onAddStream = (MediaStream stream) {
      print('new --stream--     Added!');
    };

    connection.onIceConnectionState = (RTCIceConnectionState state) {
      print('new ice state is $state');
    };

    connection.onSignalingState = (state) {
      print('new signaling state is $state');
    };

    connection.onIceGatheringState = (state) {
      print('new IceGathering state is $state');
    };

    connections[userId] =
        connection; // Store away the connection based on username
    return connection;
  }

  Future<void> cleanSessions() async {
    if (localeStream != null) {
      localeStream!.getTracks().forEach((element) async {
        await element.stop();
      });
      await localeStream!.dispose();
      localeStream = null;
    }
  }

  void muteMic() {
    if (localeStream != null) {
      bool enabled = localeStream!.getAudioTracks()[0].enabled;
      localeStream!.getAudioTracks()[0].enabled = !enabled;
    }
  }

  bool get isMute => localeStream?.getAudioTracks()[0].enabled ?? false;

  void newSignal(userId, signal) async {
    var connection = await getConnection(userId);
    var c = signal["candidate"];
    var s = signal["sdp"];
    if (c != null) {
      print("=============================================candidate");
      receivedCandidateSignal(connection, userId, c);
    }
    if (s != null) {
      print("=============================================sdp");

      receivedSdpSignal(connection, userId, s['sdp'], s['type']);
    }
  }

  void closeConnection(userId) {
    var connection = connections[userId];
    connection?.close();
    removeConnection(connection);
  }

  void removeConnection(RTCPeerConnection? connection) {
    connections.removeWhere(
      (key, value) =>
          value.iceGatheringState?.index ==
          connection?.iceGatheringState?.index,
    );
  }

  @override
  void onAccept(data) {
    print("===========(> onAccept");
  }

  @override
  void onReceiveNotification(data) {
    print("===========(> onReceiveNotification");
  }

  @override
  void onCallEndUser(data) {
    if (data == null && data!.isEmpty) return;
    closeConnection(data);
    cleanSessions();
  }

  @override
  void onCallEnd(data) {
    if (data == null && data!.isEmpty) return;
    var signalingUser = data;
    closeConnection(signalingUser['userIdHash']);
    cleanSessions();
  }

  @override
  void onDeclined(data) {
    // print(arguments);
    // _controller?.close();
  }

  @override
  Future<void> onNewCall(data) async {
    print("NEWWWWWWWWWWWWWWWWWWWW");
  }

  @override
  void onNewSignal(data) {
    if (data == null && data!.isEmpty) return;
    print("onNewSignal======================>");
    print(data);

    var signalingUser = data[0];
    var signal = data[1];
    Map<String, dynamic> user = jsonDecode(signal.toString());

    newSignal(signalingUser['userIdHash'], user);
  }

  @override
  void onNewState(data) async {
    HubConnectionState event = data;
    if (event == HubConnectionState.Connected) {
      print('joining by this data ${user?.toMap()}');
      // var status = await signalR.sendMessage("Join");
      // if (status != null && status is bool && status == true) {
      //   signalR.updateListeners((callBack) => callBack.onJoined(status));
      // }
    }
  }

  @override
  void onNewUserList(data) {
    print(data);
  }

  bool get isConnected => signalR.isConnected;

  HubConnectionState get state =>
      signalR.hubConnection?.state ?? HubConnectionState.Disconnected;

  void closeAllConnection() {
    connections.forEach((key, connection) async {
      await connection.close();
      removeConnection(connection);
    });
    cleanSessions();
  }

  void turnSpeaker(bool on) {
    if (!kIsWeb) {
      print("Setting speakerphone to: $on");
      try {
        localeStream?.getAudioTracks().forEach((track) {
          track.enableSpeakerphone(on);
        });
      } catch (e) {
        print("Error enabling speakerphone: $e");
      }
    } else {
      print("Speakerphone control is not available on web.");
    }
  }

  @override
  void onConnected(data) {
    //
  }

  @override
  void onJoined(data) {
    //
  }
}
