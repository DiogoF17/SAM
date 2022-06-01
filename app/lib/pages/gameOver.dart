import 'package:flutter/material.dart';

import "../utils/utils.dart";

import 'package:app/pages/loadingScreen.dart';

import 'package:app/loadAction/loadActionForPlayCategories.dart';
import 'package:app/loadAction/loadActionForLearnCategories.dart';

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
              action: () => {
                    nextPage(
                        context, LoadingScreen(LoadActionForPlayCategories()))
                  }),
          const SizedBox(height: 10.0),
          getPersonalizedText("Aprende novas categorias!"),
          getButton("Aprender", 150.0,
              action: () => {
                    nextPage(
                        context, LoadingScreen(LoadActionForLearnCategories()))
                  }),
          homePageIcon(context),
        ]));
  }
}
