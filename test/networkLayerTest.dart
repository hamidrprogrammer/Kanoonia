import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:kanooniha/common/imports/viewModelExports.dart';
import 'package:kanooniha/core/Logger.dart';
import 'package:kanooniha/core/flow/MyFlow.dart';
import 'package:kanooniha/domain/di/appModule.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/domain/useCase/TestApiUseCase.dart';

void main() {
  test("Network layer test", () async {
    await AppModule().initModules();
    TestApiUseCase useCase = TestApiUseCase();
    useCase.invoke(flow: MyFlow((state) {
      Logger.d(state);
      if (state.isSuccess) {
        Logger.d(state.getData);
      }
    }));
    expect(1, 1);
    GetIt.I.get<Client>().close();
  });
}
