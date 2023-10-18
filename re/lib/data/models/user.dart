import 'package:intl/intl.dart';

class User {
  final int id;
  final String username;
  final String email;
  final DateTime created;
  final DateTime updated;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.created,
    required this.updated,
  });

  // 통신을 위해서 Dart 오브젝트 => json 처럼 생긴 Map으로 변환하는 함수
  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "created": created,
    "updated": updated
  };

  // 응답 받은 데이터를 json 처럼 생긴 Map => Dart 오브젝트로 변환하는 함수
  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        username = json["username"],
        email = json["email"],
        created = DateFormat("yyyy-mm-dd").parse(json["created"]),
        updated = DateFormat("yyyy-mm-dd").parse(json["updated"]);
}