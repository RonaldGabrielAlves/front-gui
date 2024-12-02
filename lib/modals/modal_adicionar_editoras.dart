import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wdalivraia/models/notes_add_editora.dart';
import 'package:wdalivraia/models/notes_editora.dart';
import 'package:wdalivraia/models/notes_update_editora.dart';
import 'package:wdalivraia/services/editoras_services.dart';

class AdicionarEditoras extends StatefulWidget {
  final int? idedi;
  final VoidCallback? onBack;
  AdicionarEditoras({this.idedi, this.onBack});
  @override
  State<AdicionarEditoras> createState() => _AdicionarEditorasState();
}

class _AdicionarEditorasState extends State<AdicionarEditoras> {
  bool get isEditing => widget.idedi != null;
  EditorasService get service => GetIt.I<EditorasService>();

  String? errorMessage;
  NotesEditora? note;

  TextEditingController _nomediController = TextEditingController();
  TextEditingController _idediController = TextEditingController();
  TextEditingController _cidadediController = TextEditingController();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      if (widget.idedi != null) {
        setState(() {
          isLoading = true;
        });
        service.getNote(widget.idedi!).then((response) {
          setState(() {
            isLoading = false;
          });
          if (response.error != null && response.error == true) {
            errorMessage = response.errorMessage ?? 'Ocorreu um erro!';
          } else {
            note = response.data;
            _idediController.text = note!.idedi.toString();
            _nomediController.text = note!.nomedi;
            _cidadediController.text = note!.cidadedi;
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
            isEditing ? 'Editar Editora' : 'Adicionar Editora',
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
                      controller: _nomediController,
                      decoration: InputDecoration(
                          hintText: 'Nome da Editora',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(130, 20, 20, 20))),
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
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
                      controller: _cidadediController,
                      decoration: InputDecoration(
                          hintText: 'Cidade da Editora',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(130, 20, 20, 20))),
                      style:
                          TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
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
                    Builder(
                      builder: (context) => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (isEditing) {
                                final idedivar =
                                    int.parse(_idediController.text);
                                final note = NoteUpdtEditora(
                                  idedi: idedivar,
                                  nomedi: _nomediController.text,
                                  cidadedi: _cidadediController.text,
                                );
                                final result = await service.updateNote(note);
                                final textError = result.error!
                                    ? (result.errorMessage ??
                                        'Ocorreu um erro desconhecido')
                                    : 'Editora Editada!';

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
                                final note = NoteAddEditora(
                                  nomedi: _nomediController.text,
                                  cidadedi: _cidadediController.text,
                                );
                                final result = await service.createNote(note);
                                final textError = result.error!
                                    ? (result.errorMessage ??
                                        'Ocorreu um erro desconhecido')
                                    : 'Editora criada!';

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
                                const Color.fromARGB(255, 68, 0, 82)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
