class NotesItemLost {
  int id;
  String name;
  String name1;
  String color;
  bool with_label;
  bool metal;
  bool colored;
  bool broken;
  bool dirty;
  bool opaque;
  bool fragile;
  bool missing_parts;
  bool heavy;
  bool with_pockets;
  bool with_buttons;
  String other;
  int id_user;
  String date;
  String image;

  NotesItemLost(
      { required this.id,
        required this.name,
        required this.name1,
        required this.color,
        required this.with_label,
        required this.metal,
        required this.colored,
        required this.broken,
        required this.dirty,
        required this.opaque,
        required this.fragile,
        required this.missing_parts,
        required this.heavy,
        required this.with_pockets,
        required this.with_buttons,
        required this.other,
        required this.id_user,
        required this.date,
        required this.image});

  factory NotesItemLost.fromJson(Map<String, dynamic> item) {
    bool parseBool(dynamic value) {
      if (value is int) {
        return value == 1;
      } else if (value is bool) {
        return value;
      }
      return false; // valor padrão para casos não previstos
    }

    return NotesItemLost(
      id: item['id'],
      name: item['name'],
      name1: item['name1'],
      color: item['color'],
      with_label: parseBool(item['with_label']),
      metal: parseBool(item['metal']),
      colored: parseBool(item['colored']),
      broken: parseBool(item['broken']),
      dirty: parseBool(item['dirty']),
      opaque: parseBool(item['opaque']),
      fragile: parseBool(item['fragile']),
      missing_parts: parseBool(item['missing_parts']),
      heavy: parseBool(item['heavy']),
      with_pockets: parseBool(item['with_pockets']),
      with_buttons: parseBool(item['with_buttons']),
      other: item['other'],
      id_user: item['id_user'],
      date: item['date'],
      image: item['image'],
    );
  }

}