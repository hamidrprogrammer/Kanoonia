extension TimerFormatter on int {
  String? formatMMSS() {
    var seconds = this;
    if (this == 0) {
      return null;
    }
    final hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    final minutes = (seconds / 60).truncate();

    final minutesStr = (minutes).toString().padLeft(2, '0');
    final secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return '$minutesStr:$secondsStr';
    }

    return '$minutesStr:$secondsStr';
  }
}
