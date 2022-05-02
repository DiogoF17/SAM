import 'package:flutter/material.dart';

Color? GetAppThemeColor() {
  return Colors.blue[200];
}

Widget GetTitle() {
  return Text("Little Learner",
      textAlign: TextAlign.center,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 35));
}

Widget GetButton(String name, double width) {
  return ElevatedButton(
      child: Text(name,
          textAlign: TextAlign.center,
          style: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18)),
      onPressed: null,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width, 40),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))));
}

Widget GetPersonalizedText(String text,
    {alignment = TextAlign.left, fontSize = 18.0}) {
  return Text(text,
      textAlign: alignment,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: fontSize));
}
