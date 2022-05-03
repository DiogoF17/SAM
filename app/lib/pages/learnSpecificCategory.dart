import 'package:flutter/material.dart';

import "../utils/utils.dart";
import "../utils/videoPlayer.dart";

class LearnSpecificCategoryPage extends StatefulWidget {
  const LearnSpecificCategoryPage({Key? key}) : super(key: key);

  @override
  State<LearnSpecificCategoryPage> createState() =>
      _LearnSpecificCategoryPageState();
}

class _LearnSpecificCategoryPageState extends State<LearnSpecificCategoryPage> {
  @override
  Widget build(BuildContext context) {
    String categoryName = "Nomes de Animais";
    String soundName = "Cão";

    return Scaffold(
        body: Container(
            color: getAppThemeColor(),
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(children: <Widget>[
                  const SizedBox(height: 100.0),
                  // ------------------------
                  // top bar with home button
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        getTitle(),
                        IconButton(
                            icon: const Icon(Icons.home,
                                color: Colors.white, size: 35.0),
                            onPressed: () => {Navigator.pop(context)})
                      ]),
                  const SizedBox(height: 20.0),
                  // -------------
                  // category name
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: getPersonalizedText(
                          "Jogar - Categoria: " + categoryName,
                          alignment: TextAlign.center)),
                  // --------------
                  // image/video section
                  const SizedBox(height: 50.0),
                  // getImage(),
                  getVideo(),
                  const SizedBox(height: 50.0),
                  // --------------------
                  // button of hear sound
                  Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 38, 75, 130),
                          borderRadius: BorderRadius.circular(buttonRadius)),
                      padding: const EdgeInsets.only(
                          top: 7.5, bottom: 7.5, left: 20, right: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            getPersonalizedText(soundName),
                            Column(children: <Widget>[
                              const IconButton(
                                  icon: Icon(Icons.volume_up,
                                      color: Colors.white),
                                  onPressed: null),
                              getPersonalizedText("Ouvir Novamente",
                                  fontSize: 13.0)
                            ])
                          ])),
                  const SizedBox(height: 20.0),
                  // -----------------------------
                  // buttons for next and previous
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        getButton("Anterior", 175.0),
                        getButton("Próximo", 175.0)
                      ]),
                  const SizedBox(height: 20.0)
                ]))));
  }

  Widget getImage() {
    return ClipRRect(
        child: Image.asset("images/dogExample.jpeg"),
        borderRadius: BorderRadius.circular(buttonRadius));
  }

  Widget getVideo() {
    return ClipRRect(
        child: const MyVideoPlayer("Butterfly",
            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
        borderRadius: BorderRadius.circular(buttonRadius));
  }
}
