import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  late String label;
  late String hintText;
  late TextEditingController tc;
  TextBox(this.label, this.hintText, this.tc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        controller: tc,
        decoration: InputDecoration(
            labelText: label,
            hintText: hintText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: Icon(Icons.message)),
      ),
    );
  }
}
