import 'package:flutter/material.dart';

import 'pages/home.dart';
import 'pages/playCategories.dart';
import 'pages/learnCategories.dart';
import 'pages/credits.dart';
import 'pages/playSpecificCategory.dart';
import 'pages/learnSpecificCategory.dart';

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
    // home: const PlayCategoriesPage());
    // home: const LearnCategoriesPage());
    // home: const CreditsPage());
    // home: const PlaySpecificCategoryPage());
    // home: const LearnSpecificCategoryPage());
  }
}
