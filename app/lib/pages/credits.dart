import 'package:flutter/material.dart';

import "../utils/utils.dart";

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: GetAppThemeColor(),
        child: Column(children: <Widget>[
          SizedBox(height: 100.0),
          GetTitle(),
          SizedBox(height: 20.0),
          GetPersonalizedText("Créditos"),
          SizedBox(height: 80.0),
          GetPersonalizedText("Aplicação desenvolvida por:"),
          SizedBox(height: 30.0),
          GetPersonalizedText("Diogo Santos"),
          SizedBox(height: 10.0),
          GetPersonalizedText("Jéssica Nascimento"),
          SizedBox(height: 10.0),
          GetPersonalizedText("Marcelo Reis"),
          SizedBox(height: 50.0),
          GetButton("Voltar", 100.0),
        ]));
  }
}
