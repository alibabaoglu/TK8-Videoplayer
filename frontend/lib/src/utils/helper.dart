class Helper {
  static String getDuration(int milliseconds) {
    final duration = Duration(milliseconds: milliseconds.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  static String getPosition(int milliseconds) {
    final duration = Duration(milliseconds: milliseconds.round());
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  static String showVideoSpeed(double videoSpeed) {
    if (videoSpeed == 1) {
      return "    1x\nNormal"; //Leerzeichen sind bewusst vorhanden
    } else {
      return "${videoSpeed}x";
    }
  }
}
