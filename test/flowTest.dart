import 'package:flutter_test/flutter_test.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/core/Logger.dart';
import 'package:kanooniha/core/flow/MyFlow.dart';
import 'package:kanooniha/domain/useCase/TestApiUseCase.dart';

void main() {
  test("flow test", () {
    AppState appState = AppState.idle;
    TestApiUseCase().invoke(flow: MyFlow( (state) {
      Logger.d(appState);
      appState = state;
    }));
    expect(appState, AppState.error);
  });
}
