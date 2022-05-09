import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import "../utils/utils.dart";
import '../database/database.dart';
import '../database/category.dart';
import '../database/media.dart';
import "../utils/videoPlayer.dart";

class PlaySpecificCategoryPage extends StatefulWidget {
  final Category category;
  List<Media> media = [];
  List<int> sequence = [];
  int pageNumber = 0;

  PlaySpecificCategoryPage(
      this.category, this.media, this.sequence, this.pageNumber,
      {Key? key})
      : super(key: key);

  @override
  State<PlaySpecificCategoryPage> createState() =>
      _PlaySpecificCategoryPageState();
}

class _PlaySpecificCategoryPageState extends State<PlaySpecificCategoryPage> {
  List<Media> media = [];
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
      media = selectRemainingMedia(widget.media, targetMedia);
      media.add(targetMedia);
      media.shuffle();
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
                          // -------------
                          // category name
                          subtitleSpecificCategoriesPage(
                              context, widget.category.name),
                          // --------------
                          // images/videos section
                          Expanded(
                              child: GridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  children: displayMedia())),
                          // --------------------
                          // button of hear sound
                          hearSoundButton(targetMedia.name,
                              action: () => speak(targetMedia.name)),
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

  List<Widget> displayMedia() {
    if (widget.category.mediaType == MediaType.video) {
      return displayVideos();
    } else {
      return displayImages();
    }
  }

  List<Widget> displayImages() {
    List<Widget> ret = [];

    for (Media aux in media) {
      ret.add(InkWell(
        onTap: () {},
        child: ClipRRect(
            child: Image.network(aux.path, fit: BoxFit.cover,),
            borderRadius: BorderRadius.circular(buttonRadius))));
    }

    return ret;
  }

  List<Widget> displayVideos() {
    List<Widget> ret = [];

    for (Media aux in media) {
      ret.add(ClipRRect(
          child: MyVideoPlayer(aux.name, aux.path),
          borderRadius: BorderRadius.circular(buttonRadius)));
    }

    return ret;
  }
}
