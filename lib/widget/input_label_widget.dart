import 'package:flutter/material.dart';

class InputLabelWidget extends StatefulWidget {
  final int type;
  final TextEditingController controller;
  final int maxLength;
  final int minLength;
  final String placeholder;
  final String label;
  final Function()? onChanged;

  const InputLabelWidget({
    Key? key,
    required this.type,
    required this.controller,
    required this.maxLength,
    required this.minLength,
    required this.placeholder,
    required this.label,
    this.onChanged,
  }) : super(key: key);

  @override
  State<InputLabelWidget> createState() => _InputLabelWidgetState();
}

class _InputLabelWidgetState extends State<InputLabelWidget> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: widget.controller,
          maxLength: widget.maxLength,
          obscureText: widget.type == 2 && !_isPasswordVisible,
          keyboardType: widget.type == 1
              ? TextInputType.emailAddress
              : TextInputType.text,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!();
            }
          },
          decoration: InputDecoration(
            hintText: widget.placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon:  widget.type == 2 ? Icon(Icons.lock) : null,
            suffixIcon: widget.type == 2
                ? IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            )
                : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo é obrigatório';
            }
            if (value.length < widget.minLength) {
              return 'Mínimo de ${widget.minLength} caracteres';
            }
            if (value.length > widget.maxLength) {
              return 'Máximo de ${widget.maxLength} caracteres';
            }
            if (widget.type == 1 && !_isValidEmail(value)) {
              return 'Digite um email válido';
            }
            return null;
          },
        ),
      ],
    );
  }
  bool _isValidEmail(String email) {
    final emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
}

