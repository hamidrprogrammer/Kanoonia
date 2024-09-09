

class UpdateBody {
  String AppId, lastVersion;
  String? userId;

  UpdateBody({required this.AppId, required this.lastVersion, this.userId});

  Map<String, dynamic> toJson() {
    return {
      'AppId': AppId,
      'lastVersion': lastVersion,
    };
  }
}
