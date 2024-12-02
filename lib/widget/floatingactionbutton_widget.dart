import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Widget route;

  const CustomFloatingActionButton({Key? key, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => route));
      },
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Color.fromARGB(255, 68, 0, 82),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }
}
