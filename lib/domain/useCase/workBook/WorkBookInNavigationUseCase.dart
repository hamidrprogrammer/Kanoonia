import 'package:core/firebaseLogger/googleEventLogger.dart';
import 'package:kanooniha/data/body/workBook/WorkBookInNavigationBody.dart';
import 'package:kanooniha/data/serializer/user/UserDataResponse.dart';
import 'package:kanooniha/domain/network/NetworkExtensions.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';
import 'package:kanooniha/domain/useCase/user/GetUserDataFromCityUseCase.dart';

import '../../../common/user/UserSessionConst.dart';
import 'WorkBookByWorkBookBodyUseCase.dart';

class WorkBookInNavigationUseCase extends BaseUseCase {
  void getWorkBookInNavigation({
    required MyFlow<AppState> flow,
  }) async {
    try {
      GetUserDataFromUseCase().invoke(flow: MyFlow((userDataState) async {
        if (userDataState.isSuccess) {
          UserDataResponse userDataResponse = userDataState.getData;
          var workBookBody = WorkBookInNavigationBody(
            userid: await session.getData(UserSessionConst.id),
            testDate: userDataResponse.testDate?.toString() ?? '',
          );
          WorkBookByWorkBookBodyUseCase().getWorkBookByBody(
              body: workBookBody,
              flow: MyFlow((workBookState) async {
                if (workBookState.isSuccess) {
                  try {
                    GoogleEventLogger.logFirebaseEvent(
                        'workBook', workBookBody.toJson());
                  } catch (e) {
                    Logger.e(e);
                  }
                }
                flow.emit(workBookState);
              }));
        } else {
          flow.emit(userDataState);
        }
      }));
    } catch (e) {
      Logger.e(e);
      flow.emit(
        AppState.error(
          const ErrorModel(
            state: ErrorState.Message,
            message: ErrorMessages.ErrorMessage_Connection,
          ),
        ),
      );
    }
  }

  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {}
}
