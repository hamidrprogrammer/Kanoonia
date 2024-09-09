class User {
  final String userName, connectionId, userId, officeId;
  final String? firebaseUserToken;
  final bool isOffice, inCall;

  const User({
    required this.userName,
    required this.connectionId,
    required this.userId,
    required this.officeId,
    required this.isOffice,
    required this.inCall,
    this.firebaseUserToken,
  });

  Map<String, dynamic> toMap() {
    return {
      "UserName": userName,
      "ConnectionId": connectionId,
      "UserId": userId,
      "OfficeId": officeId,
      "IsOffice": isOffice,
      "InCall": inCall,
      "FirebaseUserToken": firebaseUserToken
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userName: map['UserName'],
      connectionId: map['ConnectionId'],
      userId: map['UserId'],
      officeId: map['OfficeId'],
      isOffice: map['IsOffice'],
      inCall: map['InCall'],
      firebaseUserToken: map['FirebaseUserToken'],
    );
  }
}
