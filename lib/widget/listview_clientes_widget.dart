import 'package:flutter/material.dart';
import 'package:wdalivraia/modals/modal_adicionar_clientes.dart';
import 'package:wdalivraia/services/clientes_services.dart';

class CustomListView3 extends StatelessWidget {
  final List filteredNotes;
  final Function() fetchNotes;
  final ClientesService service;

  CustomListView3(
      {required this.filteredNotes,
      required this.fetchNotes,
      required this.service});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredNotes.length,
      itemBuilder: (_, index) {
        return Dismissible(
          key: ValueKey(filteredNotes[index].idcli),
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
                  filteredNotes[index].nomecli,
                  style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                ),
                children: <Widget>[
                  Row(
                    children: [
                      Text(
                        'Email: ${filteredNotes[index].emailcli}',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Cidade: ${filteredNotes[index].cidadecli}',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Endereço: ${filteredNotes[index].enderecocli}',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 15),
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
                    content: Text('Deseja excluir este Cliente?'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          final deleteResult = await service.deleteNote(
                              filteredNotes[index].idcli.toString());
                          var message;
                          if (deleteResult.data == true) {
                            message = 'Cliente deletado com sucesso!';
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
                                'Não foi possível deletar, o cliente possui alugueis!';
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
                    content: Text('Deseja editar este Cliente?'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AdicionarClientes(
                                  idcli: filteredNotes[index].idcli,
                                  onBack: fetchNotes)));
                          Navigator.of(context).pop();
                        },
                        child: Text('Editar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false); //
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
