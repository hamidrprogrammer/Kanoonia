class SupportRequestInsertBody {
  SupportRequestInsertBody({
    required this.kindId,
    required this.body,
  });

  String kindId;
  String body;

  Map<String, dynamic> toJson() => {
        'kindId': kindId,
        'body': body,
      };
}
