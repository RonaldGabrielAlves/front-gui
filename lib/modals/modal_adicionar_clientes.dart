import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wdalivraia/models/notes_add_users.dart';
import 'package:wdalivraia/models/notes_users.dart';
import 'package:wdalivraia/models/notes_update_users.dart';
import 'package:wdalivraia/services/clientes_services.dart';

class AdicionarClientes extends StatefulWidget {
  final int? idcli;
  final VoidCallback? onBack;
  AdicionarClientes({this.idcli, this.onBack});
  @override
  State<AdicionarClientes> createState() => _AdicionarClientesState();
}

class _AdicionarClientesState extends State<AdicionarClientes> {
  bool get isEditing => widget.idcli != null;
  ClientesService get service => GetIt.I<ClientesService>();

  String? errorMessage;
  NotesClientes? note;

  TextEditingController _idcliController = TextEditingController();
  bool? typeValue;
  // TextEditingController _nomecliController = TextEditingController();
  TextEditingController _enderecocliController = TextEditingController();
  TextEditingController _cidadecliController = TextEditingController();
  TextEditingController _emailcliController = TextEditingController();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      if (widget.idcli != null) {
        setState(() {
          isLoading = true;
        });
        service.getNote(widget.idcli!).then((response) {
          setState(() {
            isLoading = false;
          });
          if (response.error != null && response.error == true) {
            errorMessage = response.errorMessage ?? 'Ocorreu um erro!';
          } else {
            note = response.data;
            _idcliController.text = note!.id.toString();
            typeValue = note!.type;
            _enderecocliController.text = note!.name.toString();
            _cidadecliController.text = note!.email.toString();
            _emailcliController.text = note!.password.toString();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 68, 0, 82),
          title: Text(
            isEditing ? 'Editar Cliente' : 'Adicionar Cliente',
            style: TextStyle(
                fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              widget.onBack?.call();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    TextFormField(
                      //controller: typeValue,
                      decoration: InputDecoration(
                          hintText: 'Nome do Cliente',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(130, 20, 20, 20))),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      validator: (value) {
                        if (value == null ||
                            value.length < 3 ||
                            value.length > 50) {
                          return 'O texto deve ter entre 3 e 50 caracteres!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _emailcliController,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(130, 20, 20, 20))),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      validator: (value) {
                        if (value == null) {
                          return 'O texto deve ser nulo!';
                        } else if (!value.contains("@") &&
                            !value.contains(".")) {
                          return 'Digite um email válido!';
                        } else if (value.length > 50) {
                          return 'O texto deve ter no máximo 50 caracteres!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _cidadecliController,
                      decoration: InputDecoration(
                          hintText: 'Cidade',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(130, 20, 20, 20))),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      validator: (value) {
                        if (value == null ||
                            value.length < 3 ||
                            value.length > 50) {
                          return 'O texto deve ter entre 3 e 50 caracteres!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _enderecocliController,
                      decoration: InputDecoration(
                          hintText: 'Endereço',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(130, 20, 20, 20))),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      validator: (value) {
                        if (value == null ||
                            value.length < 5 ||
                            value.length > 50) {
                          return 'O texto deve ter entre 5 e 50 caracteres!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Container(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (isEditing) {
                                final idclivar =
                                    int.parse(_idcliController.text);
                                final note = NoteUpdtUsers(
                                  id: idclivar,
                                  //type: _nomecliController.text,
                                  name: _enderecocliController.text,
                                  email: _cidadecliController.text,
                                  password: _emailcliController.text,
                                );
                                final result = await service.updateNote(note);
                                //final titleModal = "Info";
                                final textError = result.error!
                                    ? (result.errorMessage ??
                                        'Ocorreu um erro desconhecido')
                                    : 'Cliente editado!';

                                // Use o contexto do Builder widget
                                final snackBar = SnackBar(
                                  content: Text(textError),
                                  action: SnackBarAction(
                                    label: 'Fechar',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                widget.onBack?.call();
                                Navigator.pop(context);
                              } else {
                                final note = NoteAddUser(
                                  //type: _nomecliController.text,
                                  name: _enderecocliController.text,
                                  email: _cidadecliController.text,
                                  password: _emailcliController.text,
                                );
                                final result = await service.createNote(note);
                                //final titleModal = "Info";
                                final textError = result.error!
                                    ? (result.errorMessage ??
                                        'Ocorreu um erro desconhecido')
                                    : 'Cliente criado!';

                                // Use o contexto do Builder widget
                                final snackBar = SnackBar(
                                  content: Text(textError),
                                  action: SnackBarAction(
                                    label: 'Fechar',
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                widget.onBack?.call();
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: Text('SALVAR'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 68, 0, 82)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
