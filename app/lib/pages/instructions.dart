import 'package:flutter/material.dart';

import "../utils/utils.dart";
import "../utils/backgroundMusicController.dart";

class InstructionsPage extends StatelessWidget {
  BackgroundMusicController backgroundMusicController;

  InstructionsPage(this.backgroundMusicController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    backgroundMusicController.play();
    return Container(
        color: getAppThemeColor(),
        child: Column(children: <Widget>[
          const SizedBox(height: 100.0),
          getIcon(true),

          const SizedBox(height: 20.0),
          getPersonalizedText("Instruções"),

          const SizedBox(height: 10.0),
          getPersonalizedText("JOGAR:"),

          const SizedBox(height: 10.0),
          getPersonalizedText2("Nesta opção, poderás demonstrar o teu conhecimento! "
              "Escolhe de entre as 4 imagens, a que mais se associa à palavra que aparece abaixo. "
              "Se quiseres poderás ouvir a palavra para tentar repeti-la"),

          const SizedBox(height: 20.0),
          getPersonalizedText("APRENDER:"),

          const SizedBox(height: 10.0),
          getPersonalizedText2("Aqui aprenderás a associar cada palavra ou som à uma imagem!"),

          const SizedBox(height: 20.0),
          getPersonalizedText("MÚSICA:"),

          const SizedBox(height: 10.0),
          getPersonalizedText2("Esta opção tem várias músicas das quais podes escolher como música de fundo."),

          const SizedBox(height: 50.0),
          getButton("Voltar", 100.0, action: () => {previousPage(context)}),
        ]));
  }
}
