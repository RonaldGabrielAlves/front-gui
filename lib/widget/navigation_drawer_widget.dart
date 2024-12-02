import 'package:flutter/material.dart';
import 'package:wdalivraia/views/editora.dart';
import 'package:wdalivraia/views/livros.dart';
import 'package:wdalivraia/views/clientes.dart';

class NavigationDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
      ),
      child: Material(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 68, 0, 82),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Livraria WDA',
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              height: 80,
            ),
            const SizedBox(height: 12),
            buildMenuItem(
              text: 'Editoras',
              icon: Icons.apartment,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 12),
            buildMenuItem(
              text: 'Livros',
              icon: Icons.book,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 12),
            buildMenuItem(
              text: 'Clientes',
              icon: Icons.person,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 12),
            buildMenuItem(
              text: 'Alugueis',
              icon: Icons.add_shopping_cart,
              onClicked: () => selectedItem(context, 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.black;
    final color2 = Colors.purple;
    final hoverColor = Color.fromARGB(255, 224, 224, 224);

    return ListTile(
      leading: Icon(icon, color: color2),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop(0);
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Editoras(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Livros(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Clientes(),
        ));
        break;
      case 3:
        /*Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Alugueis(),
        ));*/
        break;
    }
  }
}
