import 'dart:convert';

import 'package:kanooniha/data/body/poll/set_poll.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/poll/poll_api_routes.dart';

class SetPollUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    assert(data != null && data is SetPollBody);
    var body = jsonEncode(data);
    var uri = createUri(path: PollApiRoutes.pollSet);
    var response = await tryCatch(future: apiServiceImpl.post(uri,data: body), flow: flow);
    if (response != null) {
      flow?.emitData('');
    }
  }

}

