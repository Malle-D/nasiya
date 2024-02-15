import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget detailsItem(String label, String title){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(
        color: Colors.black45,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 0,
      )),
      const SizedBox(height: 4),
      Text(title, style: const TextStyle(
        color: Color(0xFF303030),
        fontSize: 18,
        fontFamily: 'Nunito Sans',
        fontWeight: FontWeight.w700,
        height: 0,
      )),
    ],
  );
}