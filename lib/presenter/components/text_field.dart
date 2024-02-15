import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textField(TextEditingController controller, String label) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.text,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(10),
      label: Text(label),
      labelStyle: const TextStyle(
          color: Color(0xFF909090), fontWeight: FontWeight.w400),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
    ),
  );
}

Widget textFieldCount(TextEditingController controller, String label) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(10),
      label: Text(label),
      labelStyle: const TextStyle(
          color: Color(0xFF909090), fontWeight: FontWeight.w400),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
    ),
  );
}

Widget commentTextField(TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.multiline,
    // Установите keyboardType в TextInputType.multiline
    maxLines: null,
    // Разрешите неограниченное количество строк
    style: const TextStyle(color: Colors.black),
    decoration: const InputDecoration(
      filled: true,
      fillColor: Colors.transparent,
      label: Text("Comments"),
      contentPadding: EdgeInsets.all(10),

      labelStyle: TextStyle(
          color: Color(0xFF909090), fontWeight: FontWeight.w400),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
  );
}


Widget textFieldNumber(TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    style: const TextStyle(color: Colors.black),
    maxLength: 9,
    decoration: const InputDecoration(
      counterText: "",
      prefix: Text("+998"),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.all(10),
      label: Text("Phone Number *"),
      labelStyle: TextStyle(
          color: Color(0xFF909090), fontWeight: FontWeight.w400),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
    ),
  );
}