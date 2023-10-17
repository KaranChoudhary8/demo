import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyBoard;
  final TextEditingController controller;
  const MyInput({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.keyBoard = TextInputType.phone,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoard,
      controller: controller,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          label: Text(label),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 2)
          )
      ),
    );
  }
}