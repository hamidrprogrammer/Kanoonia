
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class CreateMessageVisitLogBody {
  String userId;

  List<VisitedMessagesBody> VisitedMessages;

  CreateMessageVisitLogBody({
    required this.userId,
    required this.VisitedMessages,
  });
  Map<String, dynamic> toJson(){
    return {
      'userId':userId,
      "VisitedMessages": List<dynamic>.from(VisitedMessages.map((x) => x.toJson())),

    };
  }

}

@JsonSerializable(explicitToJson: true)
class VisitedMessagesBody {
  String MessageId, MessageReference;

  VisitedMessagesBody({
    required this.MessageId,
    required this.MessageReference,
  });
  Map<String, dynamic> toJson(){
    return {
      'MessageId':MessageId,
      'MessageReference':MessageReference
    };
  }
}
