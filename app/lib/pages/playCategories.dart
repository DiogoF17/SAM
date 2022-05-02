import 'package:flutter/material.dart';

import "../utils/utils.dart";

class PlayCategoriesPage extends StatelessWidget {
  const PlayCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: GetAppThemeColor(),
        child: ListView(children: <Widget>[
          Column(children: <Widget>[
            SizedBox(height: 50.0),
            GetTitle(),
            SizedBox(height: 20.0),
            GetPersonalizedText("Jogar - Categorias"),
            SizedBox(height: 30.0)
          ]),
          Column(children: GetCategories()),
          Column(children: <Widget>[
            SizedBox(height: 20.0),
            GetButton("Voltar", 100.0),
            SizedBox(height: 20.0)
          ])
        ]));
  }

  List<Widget> GetCategories() {
    List<Widget> categories = [];

    for (int i = 0; i < 20; i++) {
      categories
          .add(Container(child: GetButton("Category " + i.toString(), 350.0)));
    }

    return categories;
  }
}
