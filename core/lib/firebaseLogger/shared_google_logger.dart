export 'unsupported_logger.dart'
if (dart.library.html) 'package:core/firebaseLogger/WebGoogleLogger.dart'
if (dart.library.io) 'package:core/firebaseLogger/AndroidGoogleLogger.dart';