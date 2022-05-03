import 'package:flutter/material.dart';

import "../utils/utils.dart";
import 'package:app/pages/playCategories.dart';
import 'package:app/pages/learnCategories.dart';
import 'package:app/pages/credits.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: getAppThemeColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getTitle(),
            const SizedBox(height: 40.0),
            getButton("Jogar", 150.0,
                action: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlayCategoriesPage()),
                      )
                    }),
            getButton("Aprender", 150.0,
                action: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LearnCategoriesPage()),
                      )
                    }),
            getButton("Créditos", 150.0,
                action: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreditsPage()),
                      )
                    }),
          ],
        ));
  }
}
