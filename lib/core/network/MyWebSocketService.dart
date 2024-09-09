import 'dart:async';
import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BackgroundIsolate {
  static final ReceivePort _receivePort = ReceivePort();

  static Future<void> startIsolate(String url) async {
    final isolate = await Isolate.spawn(_isolateEntry, _receivePort.sendPort);

    _receivePort.listen((message) {
      if (message is SendPort) {
        // Send initial connection request to the isolate
        message.send(url);
      }
    });
  }

  static void _isolateEntry(SendPort responsePort) async {
    final port = ReceivePort();
    responsePort.send(port.sendPort); // Send isolate's ReceivePort to main app

    final isolatePort = await port.first;

    // WebSocket logic within the isolate
    WebSocketChannel? channel;
    bool isConnected = false;

    isolatePort.listen((message) async {
      if (message == 'connect') {
        if (!isConnected) {
          try {
            channel = WebSocketChannel.connect(Uri.parse(message as String));
            isConnected = true;
            print('WebSocket connected in isolate');
          } catch (e) {
            print('Error connecting WebSocket: $e');
          }
        }
      } else if (message == 'disconnect') {
        if (isConnected) {
          await channel?.sink.close();
      channel = null;
      isConnected = false;
      print('WebSocket disconnected in isolate');
      }
      } else if (message is String) {
      // Handle received messages from the WebSocket
      print('Message received in isolate: $message');
      }
    });

    // Periodically check for connection and reconnect if necessary
    while (true) {
      if (!isConnected) {
        await Future.delayed(Duration(seconds: 10)); // Adjust reconnection interval
        isolatePort.send('connect');
      } else {
        await Future.delayed(Duration(seconds: 5)); // Adjust data retrieval interval
        // Implement logic to retrieve data from the WebSocket here (e.g., channel.stream.listen)
      }
    }
  }
}