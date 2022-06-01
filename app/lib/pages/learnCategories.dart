import 'package:flutter/material.dart';

import 'loadingScreen.dart';

import "../utils/utils.dart";

import "../database/category.dart";

import "../loadAction/loadActionForLearnCategory.dart";

class LearnCategoriesPage extends StatefulWidget {
  final List<Category> categories;

  const LearnCategoriesPage(this.categories, {Key? key}) : super(key: key);

  @override
  State<LearnCategoriesPage> createState() => _LearnCategoriesPageState();
}

class _LearnCategoriesPageState extends State<LearnCategoriesPage> {
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
          Column(children: getCategoriesWidgets(context)),
          Column(children: <Widget>[
            const SizedBox(height: 20.0),
            getButton("Voltar", 100.0, action: () => {previousPage(context)}),
            const SizedBox(height: 20.0)
          ])
        ]));
  }

  List<Widget> getCategoriesWidgets(BuildContext context) {
    List<Widget> categoriesWidget = [];

    for (Category category in widget.categories) {
      categoriesWidget.add(Container(
          child: getButton("Categoria: " + capitalize(category.name), 350.0,
              action: () => {
                    nextPage(context,
                        LoadingScreen(LoadActionForLearnCategory(category)))
                  })));
    }

    return categoriesWidget;
  }
}
