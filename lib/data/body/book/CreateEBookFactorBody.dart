class CreateEBookFactorBody {
  CreateEBookFactorBody({
    required this.userId,
    required this.bookId,
  });

  String userId;
  String bookId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['BookId'] = bookId;
    return map;
  }
}
