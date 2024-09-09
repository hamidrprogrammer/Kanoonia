export 'package:core/storage/LocalSessionRepository.dart'
    if (dart.library.html) 'package:core/storage/web/web_localSession_impl.dart'
    if (dart.library.io) 'package:core/storage/other/other_localSession_impl.dart';
