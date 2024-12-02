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
    final double bottomSheetHeight = screenHeight * 1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 17, 197),
        title: Text(
          'Adicionar Item',
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
        padding: EdgeInsets.only(top: statusBarHeight, bottom: bottomSheetHeight, left: 0, right: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
          ),
        ),
      ),
      bottomSheet: BottomSheetItem(screenHeight: screenHeight,userId: userId,),
      //bottomNavigationBar: StaticBottomNavigation(activeIcon: 1,),
    );
  }
}
