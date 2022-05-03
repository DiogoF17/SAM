import 'package:flutter/material.dart';

const appTitle = "Little Learner";

// buttons
const buttonRadius = 10.0;

Color? getAppThemeColor() {
  return Colors.blue[200];
}

Widget getTitle() {
  return const Text(appTitle,
      textAlign: TextAlign.center,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 35));
}

Widget getButton(String name, double width, {action}) {
  return ElevatedButton(
      child: Text(name,
          textAlign: TextAlign.center,
          style: const TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18)),
      onPressed: action,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width, 40),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius))));
}

Widget getPersonalizedText(String text,
    {alignment = TextAlign.left, fontSize = 18.0}) {
  return Text(text,
      textAlign: alignment,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: fontSize));
}
