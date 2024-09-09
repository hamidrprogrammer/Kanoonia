import 'package:core/network/interceptor/KanoonHttoInterceptor.dart';
import 'package:core/network/kanoonHttp/KanoonHttp.dart';
import 'package:dio/dio.dart';

class RefreshTokenInterceptor extends KanoonHttpInterceptor {
  /*
  * function to get new token and save it
  * */
  Function? func;
  final KanoonHttp api;
  final Function? failedFunc;

  RefreshTokenInterceptor({
    required this.api,
    this.func,
    this.failedFunc,
  });

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    int statusCode = err.response?.statusCode ?? 0;
    if (statusCode == 401) {
      failedFunc?.call();
      return handler.next(
        DioError.requestCancelled(
          requestOptions: err.requestOptions,
          reason: 'Failed fetch refresh token',
        ),
      );
    } else if (statusCode == 402) {
      if(func == null) {
        failedFunc?.call();
        return handler.next(
          DioError.requestCancelled(
            requestOptions: err.requestOptions,
            reason: 'Failed fetch refresh token',
          ),
        );
      }
      var refreshResult = await func!();
      if (refreshResult != null) {
        err.requestOptions.headers['Authorization'] = refreshResult;
        var res = await _retry(err.requestOptions);
        return handler.resolve(res);
      } else {
        failedFunc?.call();
        return handler.next(
          DioError.requestCancelled(
            requestOptions: err.requestOptions,
            reason: 'Failed fetch refresh token',
          ),
        );
      }
    } else {
      return handler.next(err);
    }
  }
}
