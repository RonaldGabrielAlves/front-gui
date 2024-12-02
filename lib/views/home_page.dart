import 'package:flutter/material.dart';
import '../widget/bottom_navigation_widget.dart';
import '../widget/listview_itemlost_widget.dart';
import '../widget/search_input.dart';

class HomePage extends StatefulWidget {
  final int userId;

  const HomePage({Key? key, required this.userId}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final TextEditingController searchController = TextEditingController();

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomHeight = kBottomNavigationBarHeight;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight, bottom: bottomHeight, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/logo_unifor_pequena.png',
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
              ],
            ),
            CustomTextField(controller: searchController,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        color: Colors.white, // Cor da borda
                        width: 2, // Espessura da borda
                      ),
                    ),
                    foregroundColor: Colors.grey,
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: (){},
                  child: Text(
                    "Sort by time",
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: (){},
                  child: Icon(Icons.sort, size: 30, color: Colors.black,),
                ),
              ],
            ),
            Expanded(child: CustomListView2(),),
          ],
        ),
      ),
      bottomNavigationBar: StaticBottomNavigation(activeIcon: 1, userId: userId,),
    );
  }
}
