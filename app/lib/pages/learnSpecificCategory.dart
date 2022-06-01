import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

import "../utils/utils.dart";
import '../database/image.dart';
import "../utils/mediaController.dart";

class LearnSpecificCategoryPage extends StatefulWidget {
  final MediaController mediaController;

  LearnSpecificCategoryPage(this.mediaController, {Key? key}) : super(key: key);

  @override
  State<LearnSpecificCategoryPage> createState() =>
      _LearnSpecificCategoryPageState();
}

class _LearnSpecificCategoryPageState extends State<LearnSpecificCategoryPage> {
  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer audioPlayer = AudioPlayer();

  late MyImage targetMedia;

  @override
  void initState() {
    super.initState();
    setupPage();
  }

  void setupPage() {
    targetMedia = widget.mediaController.getTargetMedia();
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
                  const SizedBox(height: 20.0),
                  subtitleSpecificCategoriesPage(
                      context, widget.mediaController.getCategoryName()),
                  const SizedBox(height: 50.0),
                  displayMedia(),
                  const SizedBox(height: 110.0),
                  displaySoundButton(),
                  const SizedBox(height: 20.0),
                  bottomButtons(context),
                  const SizedBox(height: 20.0)
                ]))));
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

  Widget displayMedia() {
    return Container(
        height: 260,
        width: 260,
        child: ClipRRect(
            child: Image.network(
              targetMedia.path,
              // fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: Text("loading"),
                );
              },
            ),
            borderRadius: BorderRadius.circular(buttonRadius)));
  }

  Widget bottomButtons(BuildContext context) {
    if (widget.mediaController.isFirstMedia()) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getButton("Próximo", 175.0, action: () {
              widget.mediaController.goToNextMedia();
              nextPage(
                  context, LearnSpecificCategoryPage(widget.mediaController));
            })
          ]);
    } else if (widget.mediaController.isLastMedia()) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getButton("Anterior", 175.0, action: () {
              widget.mediaController.goToPreviousMedia();
              previousPage(context);
            }),
          ]);
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            getButton("Anterior", 175.0, action: () {
              widget.mediaController.goToPreviousMedia();
              previousPage(context);
            }),
            getButton("Próximo", 175.0, action: () {
              widget.mediaController.goToNextMedia();
              nextPage(
                  context, LearnSpecificCategoryPage(widget.mediaController));
            })
          ]);
    }
  }
}
