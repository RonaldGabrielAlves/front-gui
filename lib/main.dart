import 'package:flutter/material.dart';
import 'package:wdalivraia/services/clientes_services.dart';
import 'package:wdalivraia/views/register_page.dart';
import 'package:wdalivraia/widget/bottom_sheet_login_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:wdalivraia/services/itemlost_services.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<ItemLostService>(ItemLostService());
  getIt.registerSingleton<ClientesService>(ClientesService());
}

void main() async{
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unifor Achados e Perdidos',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(255, 193, 154, 240),
      ),
      home: const MyHomePage(title: 'Unifor Achados e Perdidos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomSheetHeight = screenHeight * 0.45;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight, bottom: bottomSheetHeight, left: 0, right: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/logo_unifor.png',
                    width: MediaQuery.of(context).size.width * 0.50,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Bem vindo ao\nachados e perdidos",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30,),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ));
                    },
                    child: Text("cadastre-se para\ncontinuar",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: BottomSheetLogin(screenHeight: screenHeight,),
      //bottomNavigationBar: StaticBottomNavigation(activeIcon: 1,),
    );
  }
}
