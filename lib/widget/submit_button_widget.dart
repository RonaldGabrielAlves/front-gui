import 'package:flutter/material.dart';

class SubmitButtonWidget extends StatelessWidget {
  final String placeholder;
  final VoidCallback onTap;

  const SubmitButtonWidget({
    Key? key,
    required this.placeholder,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Color.fromARGB(255, 0, 17, 197),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        onPressed: onTap,
        child: Text(
          placeholder,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
