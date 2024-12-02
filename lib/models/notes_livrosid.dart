class NotesLivrosId {
  int idliv;
  String nomeliv;
  int editliv;
  String autorliv;
  String lcmliv;
  int qtdliv;

  NotesLivrosId(
      {required this.idliv,
      required this.nomeliv,
      required this.editliv,
      required this.autorliv,
      required this.lcmliv,
      required this.qtdliv});

  factory NotesLivrosId.fromJson(Map<String, dynamic> item) {
    return NotesLivrosId(
        idliv: item['idliv'],
        nomeliv: item['nomeliv'],
        editliv: item['editliv'],
        autorliv: item['autorliv'],
        lcmliv: item['lcmliv'],
        qtdliv: item['qtdliv']);
  }
}
