import 'package:flutter/material.dart';
import 'package:wdalivraia/widget/bottom_sheet_register_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
    final double bottomSheetHeight = screenHeight * 0.60;

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
            ],
          ),
        ),
      ),
      bottomSheet: BottomSheetRegister(screenHeight: screenHeight,),
      //bottomNavigationBar: StaticBottomNavigation(activeIcon: 1,),
    );
  }
}
