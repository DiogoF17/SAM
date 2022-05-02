import 'package:flutter/material.dart';

import "../utils/utils.dart";

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: GetAppThemeColor(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GetTitle(),
            SizedBox(height: 40.0),
            GetButton("Jogar", 150.0),
            GetButton("Aprender", 150.0),
            GetButton("Créditos", 150.0),
          ],
        ));
  }
}
