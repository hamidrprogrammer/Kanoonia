import 'package:kanooniha/data/serializer/poll/polls_response.dart';
import 'package:kanooniha/domain/useCase/BaseUseCase.dart';

import '../../../common/network/poll/poll_api_routes.dart';

class GetPollUseCase extends BaseUseCase {
  @override
  void invoke({MyFlow<AppState>? flow, Object? data}) async {
    var uri = createUri(path: PollApiRoutes.pollList);
    var response = await tryCatch(future: apiServiceImpl.get(uri), flow: flow);
    if (response != null) {
      flow?.emitData(pollsResponseFromJson(response));
    }
  }
}
