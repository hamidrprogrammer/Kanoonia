export 'unsupported_adapter.dart'
if (dart.library.html) 'package:core/network/kanoonHttp/web_adapter.dart'
if (dart.library.io) 'package:core/network/kanoonHttp/mobile_adapter.dart';
