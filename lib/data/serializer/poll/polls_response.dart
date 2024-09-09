import 'dart:convert';

List<PollsResponse> pollsResponseFromJson(String str) =>
    List<PollsResponse>.from(
        json.decode(str).map((x) => PollsResponse.fromJson(x)));

class PollsResponse {
  String? uniqueId;
  String? title;
  String? description;
  int? type;
  bool? isRequired;
  List<Poll>? polls;

  PollsResponse({
    this.uniqueId,
    this.title,
    this.description,
    this.type,
    this.isRequired,
    this.polls,
  });

  factory PollsResponse.fromJson(Map<String, dynamic> json) => PollsResponse(
        uniqueId: json["uniqueId"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        isRequired: json["isRequired"],
        polls: json["polls"] == null
            ? []
            : List<Poll>.from(json["polls"]!.map((x) => Poll.fromJson(x))),
      );
}

class Poll {
  int? pollId;
  int? pollDetailsId;
  int? questionNumber;
  String? question;
  List<String>? options;

  Poll({
    this.pollId,
    this.pollDetailsId,
    this.questionNumber,
    this.question,
    this.options,
  });

  factory Poll.fromJson(Map<String, dynamic> json) => Poll(
        pollId: json["pollId"],
        pollDetailsId: json["pollDetailsId"],
        questionNumber: json["questionNumber"],
        question: json["question"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
      );
}
