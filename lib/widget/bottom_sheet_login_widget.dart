import 'package:flutter/material.dart';
import 'package:wdalivraia/services/clientes_services.dart'; // Certifique-se de ter o método getNoteEmail aqui
import 'package:wdalivraia/views/home_page.dart';
import 'package:wdalivraia/views/register_page.dart';
import 'package:wdalivraia/widget/input_label_widget.dart';
import 'package:wdalivraia/widget/submit_button_widget.dart';
import 'package:wdalivraia/models/notes_users.dart'; // Importar o modelo NotesClientes

class BottomSheetLogin extends StatefulWidget {
  final double screenHeight;

  const BottomSheetLogin({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  @override
  State<BottomSheetLogin> createState() => _BottomSheetLoginState();
}

class _BottomSheetLoginState extends State<BottomSheetLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final ClientesService _clientesService = ClientesService();

  Future<void> handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    try {
      final response = await _clientesService.getNoteEmail(email);
      if (response.error! || response.data == null) {
        _showErrorDialog("Email não encontrado.");
        return;
      }

      final NotesClientes user = response.data!;
      if (user.password != password) {
        _showErrorDialog("Senha incorreta.");
        return;
      }

      // Login bem-sucedido
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomePage(userId: user.id),
      ));
    } catch (e) {
      _showErrorDialog("Erro ao realizar login. Tente novamente.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Erro"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.screenHeight * 0.45,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.only(top: 25, left: 45, right: 45, bottom: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputLabelWidget(
                  type: 1,
                  controller: emailController,
                  maxLength: 100,
                  minLength: 5,
                  placeholder: "example@gmail.com",
                  label: "Email",
                ),
                InputLabelWidget(
                  type: 2,
                  controller: passwordController,
                  maxLength: 45,
                  minLength: 6,
                  placeholder: "password",
                  label: "Senha",
                ),
                const SizedBox(height: 20),
                SubmitButtonWidget(
                  onTap: isLoading
                      ? () {}
                      : () {
                    handleLogin();
                  },
                  placeholder: isLoading ? "Carregando..." : "LOGIN",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Não tem conta?",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ));
                      },
                      child: const Text(
                        "Crie uma conta",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue, fontSize: 17),
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
