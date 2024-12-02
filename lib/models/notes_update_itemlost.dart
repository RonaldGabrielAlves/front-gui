import 'package:flutter/foundation.dart';

class NoteUpdtItemLost {
  int? id;
  String? name;
  String? color;
  bool? with_label;
  bool? metal;
  bool? colored;
  bool? broken;
  bool? dirty;
  bool? opaque;
  bool? fragile;
  bool? missing_parts;
  bool? heavy;
  bool? with_pockets;
  bool? with_buttons;
  String? other;
  int? id_user;
  String? date;
  String? image;

  NoteUpdtItemLost({
    @required this.id,
    @required this.name,
    @required this.color,
    @required this.with_label,
    @required this.metal,
    @required this.colored,
    @required this.broken,
    @required this.dirty,
    @required this.opaque,
    @required this.fragile,
    @required this.missing_parts,
    @required this.heavy,
    @required this.with_pockets,
    @required this.with_buttons,
    @required this.other,
    @required this.id_user,
    @required this.date,
    @required this.image
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "color": color,
      "with_label": with_label,
      "metal": metal,
      "colored": colored,
      "broken": broken,
      "dirty": dirty,
      "opaque": opaque,
      "fragile": fragile,
      "missing_parts": missing_parts,
      "heavy": heavy,
      "with_pockets": with_pockets,
      "with_buttons": with_buttons,
      "other": other,
      "id_user": id_user,
      "date": date,
      "image": image
    };
  }
}