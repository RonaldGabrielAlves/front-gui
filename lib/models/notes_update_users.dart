import 'package:flutter/foundation.dart';

class NoteUpdtUsers {
  int? id;
  bool? type;
  String? name;
  String? email;
  String? password;

  NoteUpdtUsers({
    @required this.id,
    @required this.type,
    @required this.name,
    @required this.email,
    @required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "name": name,
      "email": email,
      "password": password
    };
  }
}