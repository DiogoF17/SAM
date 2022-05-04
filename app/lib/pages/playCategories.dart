import 'package:flutter/material.dart';

import "../utils/utils.dart";
import './playSpecificCategory.dart';

class PlayCategoriesPage extends StatelessWidget {
  const PlayCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: getAppThemeColor(),
        child: ListView(children: <Widget>[
          Column(children: <Widget>[
            const SizedBox(height: 50.0),
            getTitle(),
            const SizedBox(height: 20.0),
            getPersonalizedText("Jogar - Categorias"),
            const SizedBox(height: 30.0)
          ]),
          Column(children: getCategories(context)),
          Column(children: <Widget>[
            const SizedBox(height: 20.0),
            getButton("Voltar", 100.0, action: () => {previousPage(context)}),
            const SizedBox(height: 20.0)
          ])
        ]));
  }

  List<Widget> getCategories(BuildContext context) {
    List<Widget> categories = [];

    for (int i = 0; i < 20; i++) {
      categories.add(Container(
          child: getButton("Category " + i.toString(), 350.0,
              action: () =>
                  {nextPage(context, const PlaySpecificCategoryPage())})));
    }

    return categories;
  }
}
