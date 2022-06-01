import 'package:flutter/material.dart';

import "../utils/utils.dart";

import 'package:app/pages/loadingScreen.dart';
import 'package:app/pages/credits.dart';

import 'package:app/database/database.dart';

import 'package:app/loadAction/loadActionForPlayCategories.dart';
import 'package:app/loadAction/loadActionForLearnCategories.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    runDBOperations();
    return Container(
        color: getAppThemeColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getTitle(),
            const SizedBox(height: 40.0),
            getButton("Jogar", 150.0,
                action: () => {
                      nextPage(
                          context, LoadingScreen(LoadActionForPlayCategories()))
                    }),
            getButton("Aprender", 150.0,
                action: () => {
                      nextPage(context,
                          LoadingScreen(LoadActionForLearnCategories()))
                    }),
            getButton("Créditos", 150.0,
                action: () => {nextPage(context, const CreditsPage())}),
          ],
        ));
  }
}
