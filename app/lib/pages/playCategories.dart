import 'package:flutter/material.dart';

import "../utils/utils.dart";

import "../loadAction/loadActionForPlayCategory.dart";

import "./loadingScreen.dart";
import "./home.dart";

import "../database/category.dart";

class PlayCategoriesPage extends StatefulWidget {
  final List<Category> categories;

  const PlayCategoriesPage(this.categories, {Key? key}) : super(key: key);

  @override
  State<PlayCategoriesPage> createState() => _PlayCategoriesPageState();
}

class _PlayCategoriesPageState extends State<PlayCategoriesPage> {
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
          Column(children: getCategoriesWidgets(context)),
          Column(children: <Widget>[
            const SizedBox(height: 20.0),
            getButton("Voltar", 100.0,
                action: () => {replaceCurrentPage(context, const HomePage())}),
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
                        LoadingScreen(LoadActionForPlayCategory(category)))
                  })));
    }

    return categoriesWidget;
  }
}
