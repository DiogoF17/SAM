import 'package:app/pages/learnCategories.dart';
import 'package:app/pages/playCategories.dart';
import 'package:flutter/material.dart';

import "../utils/utils.dart";
import 'home.dart';

class GameOver extends StatelessWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: getAppThemeColor(),
        child: Column(children: <Widget>[
          const SizedBox(height: 100.0),
          getTitle(),
          const SizedBox(height: 20.0),
          getPersonalizedText("Fim do jogo"),
          const SizedBox(height: 100.0),
          getPersonalizedText("Experimenta outra categoria!"),
          getButton("Jogar", 150.0,
              action: () => {nextPage(context, const PlayCategoriesPage())}),
          const SizedBox(height: 10.0),
          getPersonalizedText("Aprende novas categorias!"),
          getButton("Aprender", 150.0,
              action: () => {nextPage(context, const LearnCategoriesPage())}),
          homePageIcon(context),
        ]));
  }
}
