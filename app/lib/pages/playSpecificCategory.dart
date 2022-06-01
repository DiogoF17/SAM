import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

import "../utils/utils.dart";
import "../utils/mediaController.dart";

import '../database/image.dart';

import 'gameOver.dart';

class PlaySpecificCategoryPage extends StatefulWidget {
  final MediaController mediaController;

  PlaySpecificCategoryPage(this.mediaController, {Key? key}) : super(key: key);

  @override
  State<PlaySpecificCategoryPage> createState() =>
      _PlaySpecificCategoryPageState();
}

class _PlaySpecificCategoryPageState extends State<PlaySpecificCategoryPage> {
  late MyImage targetMedia;
  late List<MyImage> allMedia = [];

  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    setupPage();
  }

  void setupPage() {
    targetMedia = widget.mediaController.getTargetMedia();

    allMedia.add(targetMedia);
    allMedia = widget.mediaController.getDifferentTypesOfMedia(allMedia, 4);
    allMedia.shuffle();
  }

  void speak(String text) async {
    await flutterTts.setLanguage("pt-PT");
    await flutterTts.setPitch(1.5);
    await flutterTts.speak(text);
  }

  void playAudio(String path) async {
    await audioPlayer.play(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: getAppThemeColor(),
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(children: <Widget>[
                  const SizedBox(height: 100.0),
                  topBarSpecificCategoriesPage(context),
                  subtitleSpecificCategoriesPage(
                      context, widget.mediaController.getCategoryName()),
                  const SizedBox(height: 40.0),
                  Expanded(
                      child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          children: displayMedia(context))),
                  displaySoundButton(),
                  const SizedBox(height: 20.0)
                ]))));
  }

  List<Widget> displayMedia(BuildContext context) {
    List<Widget> ret = [];

    for (MyImage aux in allMedia) {
      ret.add(InkWell(
          onTap: () {
            verifyAnswer(aux.name, context);
          },
          child: ClipRRect(
              child: Image.network(
                aux.path,
                // fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: Text("loading"),
                  );
                },
              ),
              borderRadius: BorderRadius.circular(buttonRadius))));
    }

    return ret;
  }

  Widget displaySoundButton() {
    if (widget.mediaController.hasSounds()) {
      return hearSoundButton(targetMedia.name,
          action: () =>
              playAudio(widget.mediaController.getPathOfCurrentSound()));
    } else {
      return hearSoundButton(targetMedia.name,
          action: () => speak(targetMedia.name));
    }
  }

  // verifies the given answer and shows an icon popup
  Future verifyAnswer(String name, BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          // if the answer is correct
          if (name == targetMedia.name) {
            widget.mediaController.goToNextMedia();
            Future.delayed(Duration(milliseconds: 500), () {
              if (widget.mediaController.isLastMedia()) {
                nextPage(context, const GameOver());
              } else {
                nextPage(
                    context, PlaySpecificCategoryPage(widget.mediaController));
              }
            });
            return const Icon(
              Icons.check,
              color: Colors.green,
              size: 250.0,
            );
          }

          // if the answer is incorrect
          Future.delayed(Duration(milliseconds: 500), () {
            Navigator.of(context).pop(true);
          });
          return const Icon(
            Icons.close,
            color: Colors.red,
            size: 250.0,
          );
        });
  }
}
