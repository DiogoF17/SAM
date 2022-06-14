import 'package:flutter/material.dart';

import "../utils/utils.dart";
import "../utils/backgroundMusicController.dart";

import "../database/music.dart";

class MusicPage extends StatelessWidget {
  final BackgroundMusicController backgroundMusicController;

  const MusicPage(this.backgroundMusicController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    backgroundMusicController.play();

    List<Widget> body = [
      const SizedBox(height: 100.0),
      getTitle(),
      const SizedBox(height: 20.0),
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: getPersonalizedText("Músicas de Fundo",
              alignment: TextAlign.center)),
      const SizedBox(height: 80.0),
    ];

    body += getMusics();

    body += [
      const SizedBox(height: 50.0),
      getButton("Voltar", 100.0, action: () => {previousPage(context)})
    ];

    return Container(
        color: getAppThemeColor(),
        child: Column(
          children: body,
        ));
  }

  List<Widget> getMusics() {
    List<Music> musics = backgroundMusicController.musics;
    List<Widget> musicWidgets = [];

    for (int i = 0; i < musics.length; i++) {
      musicWidgets.add(getButton(musics[i].name, 150.0, action: () {
        backgroundMusicController.changeToMusic(i);
      }));
    }

    return musicWidgets;
  }
}
