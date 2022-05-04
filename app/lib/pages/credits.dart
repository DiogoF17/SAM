import 'package:flutter/material.dart';

import "../utils/utils.dart";

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: getAppThemeColor(),
        child: Column(children: <Widget>[
          const SizedBox(height: 100.0),
          getTitle(),
          const SizedBox(height: 20.0),
          getPersonalizedText("Créditos"),
          const SizedBox(height: 80.0),
          getPersonalizedText("Aplicação desenvolvida por:"),
          const SizedBox(height: 30.0),
          getPersonalizedText("Diogo Santos"),
          const SizedBox(height: 10.0),
          getPersonalizedText("Jéssica Nascimento"),
          const SizedBox(height: 10.0),
          getPersonalizedText("Marcelo Reis"),
          const SizedBox(height: 50.0),
          getButton("Voltar", 100.0, action: () => {previousPage(context)}),
        ]));
  }
}
