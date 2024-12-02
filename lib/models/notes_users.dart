class NotesClientes {
  int id;
  bool? type;
  String? name;
  String? email;
  String? password;

  NotesClientes(
      {required this.id,
      required this.type,
      required this.name,
      required this.email,
      required this.password});

  factory NotesClientes.fromJson(Map<String, dynamic> item) {
    return NotesClientes(
        id: item['id'],
        type: item['type'],
        name: item['name'],
        email: item['email'],
        password: item['password']);
  }
}