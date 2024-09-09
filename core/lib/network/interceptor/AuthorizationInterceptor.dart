import 'package:core/network/interceptor/KanoonHttoInterceptor.dart';
import 'package:dio/dio.dart';

class AuthorizationInterceptor extends KanoonHttpInterceptor {
  String token;

  AuthorizationInterceptor({required this.token});

  void setToken(String newToken) => token = newToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({'Authorization': 'Bearer $token'});
    return handler.next(options);
  }

}
