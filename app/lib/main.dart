import 'package:flutter/material.dart';

import 'pages/home.dart';

void main() {
  runApp(const LittleLearner());
}

class LittleLearner extends StatelessWidget {
  const LittleLearner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Little Learner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}
