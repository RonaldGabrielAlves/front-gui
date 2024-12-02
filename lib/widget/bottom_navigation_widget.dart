import 'package:flutter/material.dart';
import 'package:wdalivraia/views/home_page.dart';
import '../views/add_item_page.dart';
import '../views/notifications.dart';
import '../views/profile_page.dart';

class StaticBottomNavigation extends StatefulWidget {
  final int activeIcon;
  final int? userId;

  const StaticBottomNavigation({
    Key? key,
    required this.activeIcon,
    this.userId,
  }) : super(key: key);

  @override
  State<StaticBottomNavigation> createState() => _StaticBottomNavigationState();
}

class _StaticBottomNavigationState extends State<StaticBottomNavigation> {
  late int? userId;

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
    return BottomAppBar(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(
              icon: Icons.home,
              isActive: widget.activeIcon == 1,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(userId: userId ?? 0,)),
              ),
            ),
            buildNavItem(
                icon: Icons.explore,
                isActive: widget.activeIcon == 2,
                onTap: () {},
            ),
            buildMiddleNavItem(context),
            buildNavItem(
                icon: Icons.notifications,
                isActive: widget.activeIcon == 3,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notifications(userId: userId ?? 0,)),
                ),
            ),
            buildNavItem(
              icon: Icons.person,
              isActive: widget.activeIcon == 4,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage(userId: userId ?? 0,)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem({required IconData icon, required bool isActive, required VoidCallback onTap,}) {
    final iconColor = isActive
        ? const Color.fromARGB(255, 0, 17, 197)
        : Color.fromARGB(255, 168, 168, 168);

    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: iconColor,
        size: 35,
      ),
    );
  }

  Widget buildMiddleNavItem(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddItemPage(userId: userId ?? 0,)),
      ),
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 17, 197),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

