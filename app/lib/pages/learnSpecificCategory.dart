import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import "../utils/utils.dart";
import "../utils/videoPlayer.dart";
import '../database/media.dart';
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

  late Media targetMedia;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: getAppThemeColor(),
            child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(children: <Widget>[
                  const SizedBox(height: 100.0),
                  // ------------------------
                  // top bar with home button
                  topBarSpecificCategoriesPage(context),
                  const SizedBox(height: 20.0),
                  // -------------
                  // category name
                  subtitleSpecificCategoriesPage(
                      context, widget.mediaController.getCategoryName()),
                  // --------------
                  // image/video section
                  const SizedBox(height: 50.0),
                  displayMedia(),
                  const SizedBox(height: 110.0),
                  // --------------------
                  // button of hear sound
                  hearSoundButton(targetMedia.name,
                      action: () => speak(targetMedia.name)),
                  const SizedBox(height: 20.0),
                  // -----------------------------
                  // buttons for next and previous
                  bottomButtons(context),
                  const SizedBox(height: 20.0)
                ]))));
  }

  Widget displayMedia() {
    /*if (widget.category.mediaType == MediaType.video) {
      return displayVideo();
    } else {*/
    return displayImage();
    //}
  }

  Widget displayImage() {
    return Container(
        height: 260,
        width: 260,
        child: ClipRRect(
            child: Image.network(
              targetMedia.path,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(buttonRadius)));
  }

  Widget displayVideo() {
    return ClipRRect(
        child: MyVideoPlayer(targetMedia.name, targetMedia.path),
        borderRadius: BorderRadius.circular(buttonRadius));
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
