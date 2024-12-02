import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wdalivraia/main.dart';
import 'package:wdalivraia/widget/input_label_widget.dart';
import 'package:wdalivraia/widget/submit_button_widget.dart';
import 'package:wdalivraia/models/notes_update_users.dart';
import '../models/notes_users.dart';
import '../services/clientes_services.dart';
import '../views/home_page.dart';

class BottomSheetEditUser extends StatefulWidget {
  final int userId;
  final double screenHeight;

  const BottomSheetEditUser({
    Key? key,
    required this.screenHeight,
    required this.userId,
  }) : super(key: key);

  @override
  State<BottomSheetEditUser> createState() => _BottomSheetEditUserState();
}

class _BottomSheetEditUserState extends State<BottomSheetEditUser> {
  late int userId;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    typeValue = false;
    _loadUserData();
  }

  final service = GetIt.I.call<ClientesService>();
  String? errorMessage;
  NotesClientes? note;

  final TextEditingController typeController = TextEditingController();
  bool? typeValue;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  int selectedType = -1;

  final _formKey = GlobalKey<FormState>();

  Future<void> _loadUserData() async {
    final result = await service.getNote(userId);
    if (result.error!) {
      setState(() {
        errorMessage = result.errorMessage ?? 'Erro ao carregar usuário';
      });
    } else {
      setState(() {
        note = result.data;
        nameController.text = note?.name ?? '';
        emailController.text = note?.email ?? '';
        typeValue = note?.type;
        passwordController.text = ''; // Não carregue a senha por questões de segurança
        selectedType = (note?.type ?? false) ? 1 : 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight * 1,
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
                    SizedBox(width: 20),
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
                SizedBox(height: 20),
                InputLabelWidget(type: 3, controller: nameController, maxLength: 100, minLength: 5, placeholder: "name...", label: "Nome"),
                InputLabelWidget(type: 1, controller: emailController, maxLength: 100, minLength: 5, placeholder: "example@gmail.com", label: "Email"),
                InputLabelWidget(type: 2, controller: passwordController, maxLength: 45, minLength: 6, placeholder: "password", label: "Senha"),
                SizedBox(height: 20),
                SubmitButtonWidget(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      final note = NoteUpdtUsers(
                        id: userId,
                        type: typeValue,
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      final result = await service.updateNote(note);

                      if (result.error!) {
                        final snackBar = SnackBar(
                          content: Text(result.errorMessage ?? 'Erro ao atualizar usuário'),
                          action: SnackBarAction(label: 'Fechar', onPressed: () {}),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        Navigator.of(context).pop();
                        final snackBar = SnackBar(
                          content: const Text('Usuário atualizado com sucesso!'),
                          action: SnackBarAction(label: 'Fechar', onPressed: () {}),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  placeholder: "SALVAR",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}