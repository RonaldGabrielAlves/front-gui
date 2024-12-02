import 'package:flutter/material.dart';
import 'package:wdalivraia/modals/modal_adicionar_editoras.dart';
import 'package:wdalivraia/services/editoras_services.dart';

class CustomListView extends StatelessWidget {
  final List filteredNotes;
  final Function() fetchNotes;
  final EditorasService service;

  CustomListView(
      {required this.filteredNotes,
      required this.fetchNotes,
      required this.service});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredNotes.length,
      itemBuilder: (_, index) {
        return Dismissible(
          key: ValueKey(filteredNotes[index].idedi),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ),
          secondaryBackground: Container(
            color: Colors.orange,
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.create_rounded,
                color: Colors.white,
              ),
            ),
          ),
          child: Card(
            color: Color.fromARGB(255, 224, 224, 224),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: Colors.purple,
                collapsedIconColor: const Color.fromARGB(255, 0, 0, 0),
                childrenPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                title: Text(
                  filteredNotes[index].nomedi,
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        'Cidade: ${filteredNotes[index].cidadedi}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0), fontSize: 15),
                      ),
                    ],
                  ),
                  Container(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmação'),
                    content: Text('Deseja excluir esta Editora?'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          final deleteResult = await service.deleteNote(
                              filteredNotes[index].idedi.toString());
                          var message;
                          if (deleteResult.data == true) {
                            message = 'Editora eletada com sucesso!';
                            final snackBar = SnackBar(
                              content: Text(message),
                              action: SnackBarAction(
                                label: 'Fechar',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            message = deleteResult.errorMessage ??
                                'Não foi possível deletar, a editora possui livros!';
                            final snackBar = SnackBar(
                              content: Text(message),
                              action: SnackBarAction(
                                label: 'Fechar',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          Navigator.of(context).pop();
                          fetchNotes();
                        },
                        child: Text('Excluir'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Cancelar'),
                      ),
                    ],
                  );
                },
              );
            } else if (direction == DismissDirection.endToStart) {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmação'),
                    content: Text('Deseja editar esta Editora?'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AdicionarEditoras(
                                  idedi: filteredNotes[index].idedi,
                                  onBack: fetchNotes)));
                          Navigator.of(context).pop();
                        },
                        child: Text('Editar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Cancelar'),
                      ),
                    ],
                  );
                },
              );
            }
            return false;
          },
        );
      },
    );
  }
}
