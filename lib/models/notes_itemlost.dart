class NotesItemLost {
  int id;
  String name;
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
    return NotesItemLost(
        id: item['id'],
        name: item['name'],
        color: item['color'],
        with_label: item['with_label'],
        metal: item['metal'],
        colored: item['colored'],
        broken: item['broken'],
        dirty: item['dirty'],
        opaque: item['opaque'],
        fragile: item['fragile'],
        missing_parts: item['missing_parts'],
        heavy: item['heavy'],
        with_pockets: item['with_pockets'],
        with_buttons: item['with_buttons'],
        other: item['other'],
        id_user: item['id_user'],
        date: item['date'],
        image: item['image']);
  }
}