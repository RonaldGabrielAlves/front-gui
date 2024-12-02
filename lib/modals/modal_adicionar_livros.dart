import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:wdalivraia/models/notes_add_itemlost.dart';
import 'package:wdalivraia/models/notes_editora.dart';
import 'package:wdalivraia/models/notes_livrosid.dart';
import 'package:wdalivraia/models/notes_update_itemlost.dart';
import 'package:wdalivraia/services/editoras_services.dart';
import 'package:wdalivraia/models/api_response.dart';
import 'package:intl/intl.dart';
import 'package:wdalivraia/services/itemlost_services.dart';

class AdicionarLivros extends StatefulWidget {
  final int? idliv;
  final VoidCallback? onBack;
  AdicionarLivros({this.idliv, this.onBack});
  @override
  State<AdicionarLivros> createState() => _AdicionarLivrosState();
}

class _AdicionarLivrosState extends State<AdicionarLivros> {
  EditorasService get service => GetIt.I<EditorasService>();
  APIResponse<List<NotesEditora>>? _apiResponse;
  int? valueEditora;

  bool get isEditing => widget.idliv != null;
  ItemLostService get service1 => GetIt.I<ItemLostService>();

  String? errorMessage;
  NotesLivrosId? note;

  TextEditingController _date = TextEditingController();
  TextEditingController _idlivController = TextEditingController();
  TextEditingController _nomelivController = TextEditingController();
  TextEditingController _editlivController = TextEditingController();
  TextEditingController _autorlivController = TextEditingController();
  TextEditingController _qtdlivController = TextEditingController();

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _qtdlivController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
    if (isEditing) {
      setState(() {
        isLoading = true;
      });
      if (widget.idliv != null) {
        setState(() {
          isLoading = true;
        });
        service1.getNote(widget.idliv!).then((response) {
          setState(() {
            isLoading = false;
          });
          if (response.error != null && response.error == true) {
            errorMessage = response.errorMessage ?? 'Ocorreu um erro!';
          } else {
            note = response.data;
            _idlivController.text = note!.idliv.toString();
            final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
            final DateFormat outputFormat = DateFormat('dd/MM/yyyy');
            final DateTime date = inputFormat.parse(note!.lcmliv);
            final String formattedDate = outputFormat.format(date);
            _date.text = formattedDate;
            _nomelivController.text = note!.nomeliv;
            _editlivController.text = note!.editliv.toString();
            _autorlivController.text = note!.autorliv;
            _qtdlivController.text = note!.qtdliv.toString();
          }
        });
      }
    }
  }

  _fetchNotes() async {
    _apiResponse = await service.getNotesList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 68, 0, 82),
          title: Text(
            isEditing ? 'Editar Livro' : 'Adicionar Livro',
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
                      controller: _nomelivController,
                      decoration: InputDecoration(
                          hintText: 'Nome do Livro',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(130, 20, 20, 20))),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      validator: (value) {
                        if (value == null ||
                            value.length < 2 ||
                            value.length > 50) {
                          return 'O texto deve ter entre 2 e 50 caracteres!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _autorlivController,
                      decoration: InputDecoration(
                          hintText: 'Autor',
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
                    DropdownButtonFormField<int>(
                      value: !isEditing
                          ? valueEditora
                          : int.parse(_editlivController.text),
                      onChanged: (int? newValue) {
                        setState(() {
                          valueEditora = newValue;
                          _editlivController.text = newValue.toString();
                        });
                      },
                      dropdownColor: const Color.fromARGB(255, 255, 255, 255),
                      decoration: InputDecoration(
                          hintText: 'Editora',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(130, 20, 20, 20))),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      items: _apiResponse?.data
                          ?.map<DropdownMenuItem<int>>((NotesEditora editora) {
                        return DropdownMenuItem<int>(
                          value: editora.idedi,
                          child: Text(editora.nomedi),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Selecione uma Editora!';
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _qtdlivController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}')),
                        NumericTextFormatter()
                      ],
                      decoration: InputDecoration(
                          hintText: 'Quantidade',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(130, 20, 20, 20))),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Digite um valor positivo!';
                        } else {
                          return null;
                        }
                      },
                    ),
                    Container(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _date,
                      readOnly: true,
                      decoration: InputDecoration(
                          hintText: 'Lançamento',
                          hintStyle: TextStyle(
                              color: Color.fromARGB(130, 20, 20, 20))),
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(0000),
                            lastDate: DateTime.now());

                        if (pickeddate != null) {
                          setState(() {
                            _date.text =
                                DateFormat('dd/MM/yyyy').format(pickeddate);
                          });
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe a data de lançamento!';
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
                              final DateFormat inputFormat =
                                  DateFormat('dd/MM/yyyy');
                              final DateFormat outputFormat =
                                  DateFormat('yyyy-MM-dd');
                              final DateTime date =
                                  inputFormat.parse(_date.text);
                              final String formattedDate =
                                  outputFormat.format(date);
                              if (isEditing) {
                                final idlivvar =
                                    int.parse(_idlivController.text);
                                final editlivvar =
                                    int.parse(_editlivController.text);
                                final qtdlivvar =
                                    int.parse(_qtdlivController.text);
                                /*final note = NoteUpdtLivro(
                                  idliv: idlivvar,
                                  nomeliv: _nomelivController.text,
                                  editliv: editlivvar,
                                  autorliv: _autorlivController.text,
                                  qtdliv: qtdlivvar,
                                  lcmliv: formattedDate,
                                );*/
                                //final result = await service1.updateNote(note);
                                /*final textError = result.error!
                                    ? (result.errorMessage ??
                                        'Ocorreu um erro desconhecido')
                                    : 'Livro editado!';
*/
                                // Use o contexto do Builder widget
                                /*final snackBar = SnackBar(
                                  content: Text(textError),
                                  action: SnackBarAction(
                                    label: 'Fechar',
                                    onPressed: () {},
                                  ),
                                );*/
                                /*ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                widget.onBack?.call();
                                Navigator.pop(context);
                              } else {
                                int? editlivvar;
                                try {
                                  editlivvar =
                                      int.parse(_editlivController.text);
                                } catch (e) {
                                  // Exibe uma mensagem de erro para o usuário
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Por favor, insira um número inteiro válido para a editora'),
                                    ),
                                  );
                                }*/
                               /* editlivvar = int.parse(_editlivController.text);
                                final qtdlivvar =
                                    int.parse(_qtdlivController.text);
                                final note = NoteAddLivro(
                                  nomeliv: _nomelivController.text,
                                  editliv: editlivvar,
                                  autorliv: _autorlivController.text,
                                  lcmliv: formattedDate,
                                  qtdliv: qtdlivvar,
                                );
                                final result = await service1.createNote(note);
                                final textError = result.error!
                                    ? (result.errorMessage ??
                                        'Ocorreu um erro desconhecido')
                                    : 'Livro criado!';
*/
                                // Use o contexto do Builder widget
                                /*final snackBar = SnackBar(
                                  content: Text(textError),
                                  action: SnackBarAction(
                                    label: 'Fechar',
                                    onPressed: () {},
                                  ),
                                );*/
                                /*ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                widget.onBack?.call();
                                Navigator.pop(context);*/
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

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == '') {
      return newValue;
    } else if (newValue.text == '0') {
      return oldValue;
    } else if (double.tryParse(newValue.text) == null ||
        double.parse(newValue.text) <= 0) {
      return oldValue;
    }
    return newValue;
  }
}
