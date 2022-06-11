import 'package:flutter/material.dart';

import "../utils/utils.dart";
import "../utils/backgroundMusicController.dart";

import 'package:app/pages/loadingScreen.dart';
import 'package:app/pages/home.dart';

import 'package:app/loadAction/loadActionForPlayCategories.dart';

class GameOver extends StatelessWidget {
  BackgroundMusicController backgroundMusicController;

  GameOver(this.backgroundMusicController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    backgroundMusicController.play();
    return Container(
        color: getAppThemeColor(),
        child: Column(children: <Widget>[
          const SizedBox(height: 100.0),
          getTitle(),
          const SizedBox(height: 100.0),
          getPersonalizedText("Fim do jogo!", fontSize: 30.0),
          const SizedBox(height: 50.0),
          getButton("Jogar Novamente", 150.0,
              action: () => {
                    replaceCurrentPage(
                        context,
                        LoadingScreen(
                            LoadActionForPlayCategories(
                                backgroundMusicController),
                            backgroundMusicController))
                  }),
          const SizedBox(height: 10.0),
          getButton("Página Inicial", 150.0,
              action: () => {
                    replaceCurrentPage(
                        context, HomePage(backgroundMusicController))
                  }),
        ]));
  }
}
