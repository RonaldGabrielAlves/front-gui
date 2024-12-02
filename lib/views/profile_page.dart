import 'package:flutter/material.dart';
import 'package:wdalivraia/models/notes_users.dart';
import 'package:wdalivraia/services/clientes_services.dart';
import 'package:wdalivraia/views/about_app.dart';
import 'package:wdalivraia/views/edit_page.dart';
import 'package:wdalivraia/views/terms_and_conditions.dart';
import '../widget/bottom_navigation_widget.dart';
import '../widget/listview_itemlost_widget.dart';
import '../widget/search_input.dart';
import 'package:wdalivraia/models/api_response.dart';
import 'package:wdalivraia/models/notes_users.dart';
import 'package:wdalivraia/services/clientes_services.dart'; // Certifique-se de importar o serviço

class ProfilePage extends StatefulWidget {
  final int userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late int userId;
  late Future<APIResponse<NotesClientes>> _note;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    _note = ClientesService().getNote(userId); // Chama o serviço para pegar os dados
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    final double statusBarHeight = 0;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomHeight = kBottomNavigationBarHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 17, 197),
        title: Text(
          'Perfil',
          style: TextStyle(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight, bottom: bottomHeight, left: 0, right: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              FutureBuilder<APIResponse<NotesClientes>>(
                future: _note,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Exibe um carregando enquanto aguarda a resposta
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}');
                  } else if (snapshot.data?.error == true) {
                    return Text('Erro ao carregar os dados');
                  }

                  final notes = snapshot.data?.data;
                  final name = notes?.name ?? "Nome não disponível";
                  final email = notes?.email ?? "Email não disponível";

                  return Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.person, size: 50, color: Colors.grey)
                              ],
                            ),
                            Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black)),
                            Text(email, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.grey))
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20),
              Card(
                elevation: 0,
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Configurações Gerais",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 0,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditPage(userId: userId,),
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.key, size: 30, color: Colors.black,),
                              SizedBox(width: 10,),
                              Text("Mudar a senha", style: TextStyle(fontSize: 20, color: Colors.black),),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 30, color: Colors.grey,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 0,
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informações",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 0,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AboutApp(),
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phone_android, size: 30, color: Colors.black,),
                              SizedBox(width: 10,),
                              Text("Sobre o app", style: TextStyle(fontSize: 20, color: Colors.black),),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 30, color: Colors.grey,)
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TermsAndConditions(),
                        ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.description, size: 30, color: Colors.black,),
                              SizedBox(width: 10,),
                              Text("Termos e condições", style: TextStyle(fontSize: 20, color: Colors.black),),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 30, color: Colors.grey,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StaticBottomNavigation(activeIcon: 4, userId: userId),
    );
  }
}
