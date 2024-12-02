import 'package:flutter/foundation.dart';

class NoteUpdtEditora {
  int? idedi;
  String? nomedi;
  String? cidadedi;

  NoteUpdtEditora({
    @required this.idedi,
    @required this.nomedi,
    @required this.cidadedi,
  });

  Map<String, dynamic> toJson() {
    return {"idedi": idedi, "nomedi": nomedi, "cidadedi": cidadedi};
  }
}
