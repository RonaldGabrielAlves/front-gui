class NotesEditora {
  int idedi;
  String nomedi;
  String cidadedi;

  NotesEditora(
      {required this.idedi, required this.nomedi, required this.cidadedi});

  factory NotesEditora.fromJson(Map<String, dynamic> item) {
    return NotesEditora(
        idedi: item['idedi'],
        nomedi: item['nomedi'],
        cidadedi: item['cidadedi']);
  }
}
