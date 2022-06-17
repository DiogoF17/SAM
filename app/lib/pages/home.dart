import 'package:flutter/material.dart';

import "../utils/utils.dart";
import "../utils/backgroundMusicController.dart";

import 'package:app/pages/loadingScreen.dart';
import 'package:app/pages/credits.dart';
import 'package:app/pages/musics.dart';

import 'package:app/database/database.dart';

import 'package:app/loadAction/loadActionForPlayCategories.dart';
import 'package:app/loadAction/loadActionForLearnCategories.dart';

class HomePage extends StatelessWidget {
  final BackgroundMusicController backgroundMusicController;

  const HomePage(this.backgroundMusicController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    backgroundMusicController.play();
    run();
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
                      nextPage(
                          context,
                          LoadingScreen(
                              LoadActionForPlayCategories(
                                  backgroundMusicController),
                              backgroundMusicController))
                    }),
            getButton("Aprender", 150.0,
                action: () => {
                      nextPage(
                          context,
                          LoadingScreen(
                              LoadActionForLearnCategories(
                                  backgroundMusicController),
                              backgroundMusicController))
                    }),
            getButton("Músicas", 150.0,
                action: () =>
                    {nextPage(context, MusicPage(backgroundMusicController))}),
            getButton("Créditos", 150.0,
                action: () => {
                      nextPage(context, CreditsPage(backgroundMusicController))
                    }),
          ],
        ));
  }
}
