import 'package:flutter/material.dart';

import "../utils/utils.dart";

class PlaySpecificCategoryPage extends StatefulWidget {
  const PlaySpecificCategoryPage({Key? key}) : super(key: key);

  @override
  State<PlaySpecificCategoryPage> createState() =>
      _PlaySpecificCategoryPageState();
}

class _PlaySpecificCategoryPageState extends State<PlaySpecificCategoryPage> {
  @override
  Widget build(BuildContext context) {
    String categoryName = "Nomes de Animais";

    return Container(
        color: GetAppThemeColor(),
        child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(children: <Widget>[
              SizedBox(height: 100.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GetTitle(),
                    IconButton(
                        icon: Icon(Icons.home, color: Colors.white, size: 35.0),
                        onPressed: null)
                  ]),
              SizedBox(height: 20.0),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: GetPersonalizedText(
                      "Jogar - Categoria: " + categoryName,
                      alignment: TextAlign.center)),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      children: DisplayImages())),
              Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 38, 75, 130),
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.only(
                      top: 7.5, bottom: 7.5, left: 20, right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GetPersonalizedText("Cão"),
                        Column(children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.volume_up, color: Colors.white),
                              onPressed: null),
                          GetPersonalizedText("Ouvir Novamente", fontSize: 13.0)
                        ])
                      ])),
              SizedBox(height: 20.0),
              // Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       GetButton("Anterior", 175.0),
              //       GetButton("Próximo", 175.0)
              //     ]),
              // SizedBox(height: 20.0)
            ])));
  }

  List<Widget> DisplayImages() {
    List<Widget> ret = [];

    for (int i = 0; i < 4; i++) {
      ret.add(ClipRRect(
          child: Image.asset("images/dogExample.jpeg"),
          borderRadius: BorderRadius.circular(10)));
    }

    return ret;
  }
}
