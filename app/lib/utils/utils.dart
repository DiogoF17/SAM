import 'package:app/pages/home.dart';
import 'package:flutter/material.dart';
import "dart:math";

import "../database/media.dart";

const appTitle = "Little Learner";

// buttons
const buttonRadius = 10.0;

Color? getAppThemeColor() {
  return Colors.blue[200];
}

Widget getTitle() {
  return const Text(appTitle,
      textAlign: TextAlign.center,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 35));
}

Widget getButton(String name, double width, {action}) {
  return ElevatedButton(
      child: Text(name,
          textAlign: TextAlign.center,
          style: const TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18)),
      onPressed: action,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width, 40),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius))));
}

Widget getPersonalizedText(String text,
    {alignment = TextAlign.left, fontSize = 18.0}) {
  return Text(text,
      textAlign: alignment,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: fontSize));
}

Widget loadingScreen() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget errorScreen() {
  return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
          alignment: Alignment.center,
          child: getPersonalizedText(
              "Ocorreu algum problema, pedimos desculpa!",
              fontSize: 23.0)));
}

Widget hearSoundButton(String soundName, {action}) {
  return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 38, 75, 130),
          borderRadius: BorderRadius.circular(buttonRadius)),
      padding:
          const EdgeInsets.only(top: 7.5, bottom: 7.5, left: 20, right: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            getPersonalizedText(capitalize(soundName)),
            Column(children: <Widget>[
              IconButton(
                  icon: Icon(Icons.volume_up, color: Colors.white),
                  onPressed: action),
              getPersonalizedText("Ouvir Novamente", fontSize: 13.0)
            ])
          ]));
}

Widget topBarSpecificCategoriesPage(BuildContext context) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        getTitle(),
        IconButton(
            icon: const Icon(Icons.home, color: Colors.white, size: 35.0),
            onPressed: () => {clearNavigationStack(context,HomePage())})
      ]);
}

Widget subtitleSpecificCategoriesPage(
    BuildContext context, String categoryName) {
  return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: getPersonalizedText("Aprender - Categoria: " + capitalize(categoryName),
          alignment: TextAlign.center));
}

// ************************************************************************************

// Pages

void nextPage(BuildContext context, Widget nextPage) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => nextPage),
  );
}

void previousPage(BuildContext context) {
  Navigator.pop(context);
}

void clearNavigationStack(BuildContext context, Widget page){
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => page,
    ),
        (route) => false,
  );
}
// ************************************************************************************

List<int> generateSequence(List<Media> media, int size) {
  List<int> indexes = [];
  for (int i = 0; i < media.length; i++) {
    indexes.add(i);
  }

  indexes.shuffle();

  if (size >= indexes.length) {
    return indexes;
  } else {
    return indexes.sublist(0, size);
  }
}

List<Media> selectRemainingMedia(List<Media> media, Media targetMedia) {
  List<int> indexes = [];

  var random = Random();
  int index;
  while (indexes.length < 3) {
    index = random.nextInt(media.length);
    if (!indexes.contains(index) && media[index].id != targetMedia.id) {
      indexes.add(index);
    }
  }

  return [media[indexes[0]], media[indexes[1]], media[indexes[2]]];
}

String capitalize(String string){
  if (string.isEmpty) {
    return string;
  }
  return string[0].toUpperCase() + string.substring(1);
}
