// ignore_for_file: public_member_api_docs, sort_constructors_first
class Status {
  final String uid;
  final String username;
  final String phoneNumber;
  final List<String> photoUrl;
  final DateTime createdAt;
  final String profilePic;
  final String ststusId;
  final List<String> whoCanSee;
  Status({
    required this.uid,
    required this.username,
    required this.phoneNumber,
    required this.photoUrl,
    required this.createdAt,
    required this.profilePic,
    required this.ststusId,
    required this.whoCanSee,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'profilePic': profilePic,
      'ststusId': ststusId,
      'whoCanSee': whoCanSee,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
        uid: map['uid'] ?? '',
        username: map['username'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        photoUrl: List<String>.from(map['photoUrl']),
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
        profilePic: map['profilePic'] ?? '',
        ststusId: map['ststusId'] ?? '',
        whoCanSee: List<String>.from(
          (map['whoCanSee']),
        ));
  }
}
