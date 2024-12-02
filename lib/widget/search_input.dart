import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 16.0),
      child: Card(
        color: Colors.white,
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Search here...',
            hintStyle: TextStyle(color: Color.fromARGB(130, 20, 20, 20)),
            suffixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );
  }
}
