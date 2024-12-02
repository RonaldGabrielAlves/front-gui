import 'package:flutter/foundation.dart';

class NoteAddUser {
  bool? type;
  String? name;
  String? email;
  String? password;

  NoteAddUser({
    @required this.type,
    @required this.name,
    @required this.email,
    @required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "name": name,
      "email": email,
      "password": password
    };
  }
}
