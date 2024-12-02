import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wdalivraia/main.dart';
import 'package:wdalivraia/widget/input_label_widget.dart';
import 'package:wdalivraia/widget/submit_button_widget.dart';
import 'package:wdalivraia/models/notes_add_users.dart';

import '../models/notes_users.dart';
import '../services/clientes_services.dart';
import '../views/home_page.dart';

class BottomSheetRegister extends StatefulWidget {
  final double screenHeight;

  const BottomSheetRegister({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  @override
  State<BottomSheetRegister> createState() => _BottomSheetRegisterState();
}

class _BottomSheetRegisterState extends State<BottomSheetRegister> {
  ClientesService get service => GetIt.I<ClientesService>();

  String? errorMessage;
  NotesClientes? note;

  final TextEditingController typeController = TextEditingController();
  bool? typeValue;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  int selectedType = -1;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight * 0.60,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 45, right: 45, bottom: 10),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = 0; // Aluno
                          typeValue = false;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Aluno",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedType == 0 ? Colors.blue : Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: selectedType == 0
                                ? const Icon(Icons.close, color: Colors.red, size: 33)
                                : null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedType = 1; // Funcionário
                          typeValue = true;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Funcionário",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedType == 1 ? Colors.blue : Colors.grey,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: selectedType == 1
                                ? const Icon(Icons.close, color: Colors.red, size: 33)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                InputLabelWidget(type: 3, controller: nameController, maxLength: 100, minLength: 5, placeholder: "name...", label: "Nome"),
                InputLabelWidget(type: 1, controller: emailController, maxLength: 50, minLength: 5, placeholder: "example@gmail.com", label: "Email"),
                InputLabelWidget(type: 2, controller: passwordController, maxLength: 50, minLength: 6, placeholder: "password", label: "Senha"),
                SizedBox(height: 20,),
                SubmitButtonWidget(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final note = NoteAddUser(
                        type: typeValue,
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      print('Dados enviados: ${note.toJson()}');

                      // Chama o serviço para criar o usuário
                      final result = await service.createNote(note);

                      // Verifica o resultado da operação
                      if (result.error!) {
                        // Se houve erro, exibe a mensagem de erro
                        final textError = result.errorMessage ?? 'Ocorreu um erro desconhecido';
                        final snackBar = SnackBar(
                          content: Text(textError),
                          action: SnackBarAction(
                            label: 'Fechar',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        // Se a operação foi bem-sucedida, exibe a mensagem de sucesso
                        final snackBar = SnackBar(
                          content: const Text('Usuário criado com sucesso!'),
                          action: SnackBarAction(
                            label: 'Fechar',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        // Navega para a homepage
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage(userId: 1)),
                        );
                      }
                    }
                  },
                  placeholder: "CADASTRE-SE",
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Já tem conta?",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 17,),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ));
                      },
                      child: Text("Entrar na conta",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue, fontSize: 17,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

