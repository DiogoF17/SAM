import 'package:flutter/material.dart';

import "../utils/utils.dart";

class LearnCategoriesPage extends StatelessWidget {
  const LearnCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: getAppThemeColor(),
        child: ListView(children: <Widget>[
          Column(children: <Widget>[
            const SizedBox(height: 50.0),
            getTitle(),
            const SizedBox(height: 20.0),
            getPersonalizedText("Aprender - Categorias"),
            const SizedBox(height: 30.0)
          ]),
          Column(children: getCategories()),
          Column(children: <Widget>[
            const SizedBox(height: 20.0),
            getButton("Voltar", 100.0),
            const SizedBox(height: 20.0)
          ])
        ]));
  }

  List<Widget> getCategories() {
    List<Widget> categories = [];

    for (int i = 0; i < 20; i++) {
      categories
          .add(Container(child: getButton("Category " + i.toString(), 350.0)));
    }

    return categories;
  }
}
