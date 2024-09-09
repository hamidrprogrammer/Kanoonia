import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';


part 'set_poll.g.dart';
@JsonSerializable(explicitToJson: true)
class SetPollBody{
  String uniqueId, pollDetailId;
  String? answer, selectedOption;
  List<String>? checkedOptions;

  SetPollBody({
    required this.uniqueId,
    required this.pollDetailId,
    this.answer,
    this.selectedOption,
    this.checkedOptions
});

  Map<String, dynamic> toJson() => _$SetPollBodyToJson(this);
}