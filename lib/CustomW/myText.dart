import 'package:flutter/material.dart';

class MyText extends StatelessWidget {

  const MyText({
    super.key,
    required this.text
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 24, color: Colors.white),);
  }
}