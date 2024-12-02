import 'package:flutter/foundation.dart';

class NoteAddEditora {
  String? nomedi;
  String? cidadedi;

  NoteAddEditora({
    @required this.nomedi,
    @required this.cidadedi,
  });

  Map<String, dynamic> toJson() {
    return {"nomedi": nomedi, "cidadedi": cidadedi};
  }
}
