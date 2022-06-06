import 'package:app/pages/home.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

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
  return InkWell(
      onTap: action,
      child: Container(
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 38, 75, 130),
              borderRadius: BorderRadius.circular(buttonRadius)),
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getPersonalizedText(capitalize(soundName)),
                Column(children: <Widget>[
                  const Icon(Icons.volume_up, color: Colors.white),
                  getPersonalizedText("Ouvir Novamente", fontSize: 13.0)
                ])
              ])));
}

Widget homePageIcon(BuildContext context) {
  return Material(
    color: getAppThemeColor(),
    child: Center(
      child: IconButton(
        icon: const Icon(Icons.home),
        color: Colors.white,
        onPressed: () => {clearNavigationStack(context, HomePage())},
      ),
    ),
  );
}

Widget topBarSpecificCategoriesPage(BuildContext context, AudioPlayer audioPlayer) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        getTitle(),
        IconButton(
            icon: const Icon(Icons.home, color: Colors.white, size: 35.0),
            onPressed: () {
              audioPlayer.stop();
              clearNavigationStack(context, const HomePage());
            })
      ]);
}

Widget subtitleSpecificCategoriesPage(
    BuildContext context, String categoryName, String typeName) {
  return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: getPersonalizedText(
          typeName + " - Categoria:\n" + capitalize(categoryName),
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

void replaceCurrentPage(BuildContext context, Widget nextPage) {
  Navigator.pushReplacement<void, void>(
    context,
    MaterialPageRoute(builder: (context) => nextPage),
  );
}

void previousPage(BuildContext context) {
  Navigator.pop(context);
}

void clearNavigationStack(BuildContext context, Widget page) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (BuildContext context) => page,
    ),
    (route) => false,
  );
}
// ************************************************************************************

String capitalize(String string) {
  if (string.isEmpty) {
    return string;
  }
  return string[0].toUpperCase() + string.substring(1);
}
