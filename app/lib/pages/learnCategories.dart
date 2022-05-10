import 'package:flutter/material.dart';

import "../utils/utils.dart";
import './learnSpecificCategory.dart';
import "../database/database.dart";
import "../database/category.dart";

class LearnCategoriesPage extends StatefulWidget {
  const LearnCategoriesPage({Key? key}) : super(key: key);

  @override
  State<LearnCategoriesPage> createState() => _LearnCategoriesPageState();
}

class _LearnCategoriesPageState extends State<LearnCategoriesPage> {
  List<Category> categories = [];

  Future<void> getCategories() async {
    categories = await loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: getAppThemeColor(),
        child: FutureBuilder(
          future: getCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(children: <Widget>[
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
                  getButton("Voltar", 100.0,
                      action: () => {previousPage(context)}),
                  const SizedBox(height: 20.0)
                ])
              ]);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  List<Widget> getCategoriesWidgets(BuildContext context) {
    List<Widget> categoriesWidget = [];

    for (Category category in categories) {
      categoriesWidget.add(Container(
          child: getButton("Categoria: " + capitalize(category.name), 350.0,
              action: () => {
                    nextPage(
                        context, LearnSpecificCategoryPage(category, [], [], 0))
                  })));
    }

    return categoriesWidget;
  }
}
