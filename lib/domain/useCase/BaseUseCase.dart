export 'package:get_it/get_it.dart';
export 'package:http/http.dart';
export 'package:kanooniha/common/network/NetworkConsts.dart';
export 'package:kanooniha/common/ui/ErrorMessages.dart';
export 'package:kanooniha/core/Logger.dart';
export 'package:kanooniha/core/flow/MyFlow.dart';
export 'package:kanooniha/core/network/UriCreator.dart';
export 'package:kanooniha/domain/errorHandler/ErrorHanlderImpl.dart';
export 'package:kanooniha/domain/errorHandler/ErrorModel.dart';
export 'package:kanooniha/presentation/states/app_state.dart';
export 'package:core/network/network.dart';
export 'package:core/storage/shared/LocalSessionImpl.dart';

import 'package:kanooniha/core/network/ResponseExtension.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

abstract class BaseUseCase {
  KanoonHttp apiServiceImpl = GetIt.I.get();
  LocalSessionImpl session = GetIt.I.get<LocalSessionImpl>();


  void invoke({MyFlow<AppState>? flow, Object? data});

  Future<String?> tryCatch({
    required Future<KanoonHttpResponse> future,
    MyFlow<AppState>? flow,
  }) async {
    try {
      flow?.emitLoading();
      KanoonHttpResponse response = await future;
      if (response.isSuccessful) {
        var result = response.result;
        if (result.isSuccessFull && result.data != null) {
          return Future.value(result.data);
        } else {
          flow?.throwMessage(result.errorMessage);
          return null;
        }
      } else {
        flow?.throwError(response);
        return null;
      }
    } catch (e) {
      Logger.e(e);
      flow?.throwCatch();
      return null;
    }
  }

  Uri createUri({String? path, Map<String, dynamic>? body}) {
    return UriCreator.createUriWithUrl(
        url: NetworkConsts.BaseUrl,
        path: NetworkConsts.BasePath + (path ?? ''),
        body: body);
  }
}

extension FlowExtension on MyFlow<AppState> {
  void throwCatch() {
    emit(
      AppState.error(
        const ErrorModel(
          state: ErrorState.Message,
          message: ErrorMessages.ErrorMessage_Connection,
        ),
      ),
    );
  }

  void throwError(KanoonHttpResponse? response, {int? statusCode}) {
    if (response != null) {
      emit(
        AppState.error(
          ErrorHandlerImpl().makeError(response),
        ),
      );
    }
    if (statusCode != null) {
      emit(
        AppState.error(
          ErrorHandlerImpl().makeErrorByStatusCode(statusCode),
        ),
      );
    }
  }

  void throwMessage(String msg) {
    emit(
      AppState.error(ErrorModel(state: ErrorState.Message, message: msg)),
    );
  }

  void throwEmptyDataMessage(String msg) {
    emit(
      AppState.error(ErrorModel(state: ErrorState.Empty, message: msg)),
    );
  }

  void emitLoading() {
    emit(AppState.loading);
  }

  void emitData(dynamic data) {
    emit(AppState.success(data));
  }
}
