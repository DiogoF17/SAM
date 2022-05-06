import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import "../utils/utils.dart";
import "../utils/videoPlayer.dart";
import '../database/media.dart';
import '../database/category.dart';
import '../database/database.dart';

class LearnSpecificCategoryPage extends StatefulWidget {
  final Category category;
  List<Media> media = [];
  List<int> sequence = [];
  int pageNumber = 0;

  LearnSpecificCategoryPage(
      this.category, this.media, this.sequence, this.pageNumber,
      {Key? key})
      : super(key: key);

  @override
  State<LearnSpecificCategoryPage> createState() =>
      _LearnSpecificCategoryPageState();
}

class _LearnSpecificCategoryPageState extends State<LearnSpecificCategoryPage> {
  Media targetMedia = Media();
  bool hasInfo = false;

  final FlutterTts flutterTts = FlutterTts();

  Future<void> loadPage() async {
    if (widget.media.isEmpty) {
      widget.media = await loadMedia(widget.category);
    }

    if (widget.sequence.isEmpty) {
      widget.sequence = generateSequence(widget.media, 5);
      widget.pageNumber = 0;
    }

    if (widget.pageNumber <= (widget.sequence.length - 1)) {
      targetMedia = widget.media[widget.sequence[widget.pageNumber]];
      hasInfo = true;
    }
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
            child: FutureBuilder(
              future: loadPage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (hasInfo) {
                    return Padding(
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
                              context, widget.category.name),
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
                        ]));
                  } else {
                    return errorScreen();
                  }
                } else {
                  return loadingScreen();
                }
              },
            )));
  }

  Widget displayMedia() {
    if (widget.category.mediaType == MediaType.video) {
      return displayVideo();
    } else {
      return displayImage();
    }
  }

  Widget displayImage() {
    return ClipRRect(
        child: Image.network(targetMedia.path),
        borderRadius: BorderRadius.circular(buttonRadius));
  }

  Widget displayVideo() {
    return ClipRRect(
        child: MyVideoPlayer(targetMedia.name, targetMedia.path),
        borderRadius: BorderRadius.circular(buttonRadius));
  }

  Widget bottomButtons(BuildContext context) {
    if (widget.pageNumber == 0) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getButton("Próximo", 175.0,
                action: () => {
                      nextPage(
                          context,
                          LearnSpecificCategoryPage(
                              widget.category,
                              widget.media,
                              widget.sequence,
                              widget.pageNumber + 1))
                    })
          ]);
    } else if ((widget.sequence.length - 1) == widget.pageNumber) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getButton("Anterior", 175.0, action: () => {previousPage(context)}),
          ]);
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            getButton("Anterior", 175.0, action: () => {previousPage(context)}),
            getButton("Próximo", 175.0,
                action: () => {
                      nextPage(
                          context,
                          LearnSpecificCategoryPage(
                              widget.category,
                              widget.media,
                              widget.sequence,
                              widget.pageNumber + 1))
                    })
          ]);
    }
  }
}
