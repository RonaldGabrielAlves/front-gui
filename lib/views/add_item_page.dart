import 'package:flutter/material.dart';
import 'package:wdalivraia/widget/bottom_sheet_register_widget.dart';

import '../widget/bottom_sheet_item.dart';

class AddItemPage extends StatefulWidget {
  final int userId;

  const AddItemPage({Key? key, required this.userId}) : super(key: key);
  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  late int userId;

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomSheetHeight = screenHeight * 0.90;

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
      bottomSheet: BottomSheetItem(screenHeight: screenHeight,userId: userId,),
      //bottomNavigationBar: StaticBottomNavigation(activeIcon: 1,),
    );
  }
}
