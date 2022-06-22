import 'package:flutter/material.dart';

import "../utils/utils.dart";
import "../utils/backgroundMusicController.dart";

class CreditsPage extends StatelessWidget {
  BackgroundMusicController backgroundMusicController;

  CreditsPage(this.backgroundMusicController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    backgroundMusicController.play();
    return Container(
        color: getAppThemeColor(),
        child: Column(children: <Widget>[
          const SizedBox(height: 100.0),
          getIcon(true),
          const SizedBox(height: 20.0),
          getPersonalizedText("Créditos"),
          const SizedBox(height: 20.0),
          getPersonalizedText2("Aplicação desenvolvida por:"),
          const SizedBox(height: 15.0),
          getPersonalizedText2("Diogo Santos"),
          const SizedBox(height: 10.0),
          getPersonalizedText2("Jéssica Nascimento"),
          const SizedBox(height: 10.0),
          getPersonalizedText2("Marcelo Reis"),
          const SizedBox(height: 125.0),
          getButton("Voltar", 100.0, action: () => {previousPage(context)}),
        ]));
  }
}
