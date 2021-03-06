import 'package:flutter/material.dart';

import 'loadingScreen.dart';
import 'home.dart';

import "../utils/utils.dart";
import "../utils/backgroundMusicController.dart";

import "../database/category.dart";

import "../loadAction/loadActionForLearnCategory.dart";

class LearnCategoriesPage extends StatefulWidget {
  BackgroundMusicController backgroundMusicController;
  final List<Category> categories;

  LearnCategoriesPage(this.backgroundMusicController, this.categories,
      {Key? key})
      : super(key: key);

  @override
  State<LearnCategoriesPage> createState() => _LearnCategoriesPageState();
}

class _LearnCategoriesPageState extends State<LearnCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    widget.backgroundMusicController.play();
    return Container(
        color: getAppThemeColor(),
        child: ListView(children: <Widget>[
          Column(children: <Widget>[
            const SizedBox(height: 50.0),
            getIcon(true),
            const SizedBox(height: 20.0),
            getPersonalizedText("Aprender - Categorias"),
            const SizedBox(height: 30.0)
          ]),
          Column(children: getCategoriesWidgets(context)),
          Column(children: <Widget>[
            const SizedBox(height: 20.0),
            getButton("Voltar", 100.0,
                action: () => {
                      replaceCurrentPage(
                          context, HomePage(widget.backgroundMusicController))
                    }),
            const SizedBox(height: 20.0)
          ])
        ]));
  }

  List<Widget> getCategoriesWidgets(BuildContext context) {
    List<Widget> categoriesWidget = [];

    for (Category category in widget.categories) {
      categoriesWidget.add(Container(
          child: getButton("Categoria: " + capitalize(category.name), 350.0,
              action: () {
        nextPage(
            context,
            LoadingScreen(
                LoadActionForLearnCategory(
                    category, widget.backgroundMusicController),
                widget.backgroundMusicController));
      })));
    }

    return categoriesWidget;
  }
}
