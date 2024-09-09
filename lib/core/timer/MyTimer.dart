import 'dart:async';

import 'package:kanooniha/core/TimeFormatter.dart';

class MyTimer {
  MyTimer({required this.start});

  late Timer _timer;
  int start;
  OnTimerChange? flow;

  void setOnChangeListener(OnTimerChange flow) {
    this.flow = flow;
  }

  void dispose() {
    _timer.cancel();
  }

  Timer? get getTimer => _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          pushUpdate();
          timer.cancel();
        } else {
          pushUpdate();
          start--;
        }
      },
    );

  }

  String? get getTime => start.formatMMSS();

  void resetTimer(int time) {
    start = time;
    startTimer();
  }

  void pushUpdate() {
    flow?.onchange(start);
  }
}

abstract class OnTimerChange {
  void onchange(int value);
}
