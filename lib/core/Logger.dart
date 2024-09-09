import 'package:flutter/foundation.dart';

class Logger{

  Logger.d(Object msg){
    if (kDebugMode) {
      print("Logger ${msg.toString()}");
    }
  }

  Logger.e(Object msg){
    if (kDebugMode) {
      print("Logger => error ${msg.toString()}");
    }
  }
}