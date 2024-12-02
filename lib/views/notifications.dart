import 'package:flutter/material.dart';
import '../widget/bottom_navigation_widget.dart';

class Notifications extends StatefulWidget {
  final int userId;

  const Notifications({Key? key, required this.userId}) : super(key: key);
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
    final double statusBarHeight = 0;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomHeight = kBottomNavigationBarHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 17, 197),
        title: Text(
          'Notificações',
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
        padding: EdgeInsets.only(top: statusBarHeight + 20, bottom: bottomHeight, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Mostrar todos", style: TextStyle(fontSize: 14,),),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text("Classificar por tempo", style: TextStyle(fontSize: 14,),),
                      Icon(Icons.arrow_drop_down, size: 22, color: Colors.grey,),
                    ],
                  ),
                )
              ],
            ),
            /*Expanded(
              child: SingleChildScrollView(
                child: ListView(),
              ),
            ),*/
          ],
        ),
      ),
      bottomNavigationBar: StaticBottomNavigation(activeIcon: 3, userId: userId,),
    );
  }
}
