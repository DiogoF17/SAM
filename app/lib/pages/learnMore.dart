import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import "../utils/utils.dart";
import "./home.dart";

class LearnMorePage extends StatefulWidget {
  final String name;
  final String path;

  const LearnMorePage(this.name, this.path, {Key? key}) : super(key: key);

  @override
  State<LearnMorePage> createState() => _LearnMorePageState();
}

class _LearnMorePageState extends State<LearnMorePage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.path)!,
        flags:
            const YoutubePlayerFlags(mute: false, loop: true, autoPlay: true));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) => Scaffold(
            body: Container(
                color: getAppThemeColor(),
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(children: <Widget>[
                      const SizedBox(height: 100.0),
                      topBar(context),
                      const SizedBox(height: 20.0),
                      subtitle(),
                      const SizedBox(height: 50.0),
                      Container(alignment: Alignment.center, child: player)
                    ])))));
  }

  Widget topBar(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              icon:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 35.0),
              onPressed: () {
                previousPage(context);
              }),
          getTitle(),
          IconButton(
              icon: const Icon(Icons.home, color: Colors.white, size: 35.0),
              onPressed: () {
                clearNavigationStack(context, const HomePage());
              })
        ]);
  }

  Widget subtitle() {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: getPersonalizedText(
            "Aprender mais sobre: " + capitalize(widget.name),
            alignment: TextAlign.center));
  }
}
