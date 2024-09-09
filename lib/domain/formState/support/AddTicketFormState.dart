import 'package:kanooniha/data/body/support/support_request_insert_body.dart';

import '../MyFormState.dart';

class AddTicketFormState extends MyFormState {
  AddTicketFormState({
    this.kindId = '',
    this.body = '',
  });

  String kindId, body;

  createBody() => SupportRequestInsertBody(kindId: kindId, body: body);
}
