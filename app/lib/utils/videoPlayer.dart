import 'package:flutter/material.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';

class MyVideoPlayer extends StatefulWidget {
  final String name;
  final String path;

  const MyVideoPlayer(this.name, this.path, {Key? key}) : super(key: key);

  @override
  State<MyVideoPlayer> createState() => _MyVideoPlayerState();
}

class _MyVideoPlayerState extends State<MyVideoPlayer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(
      widget.path,
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void pauseVideo() {
    setState(() {
      _controller.pause();
    });
  }

  void playVideo() {
    setState(() {
      _controller.play();
    });
  }

  void videoTapped() {
    bool isPlaying = _controller.value.isPlaying;

    if (isPlaying) {
      pauseVideo();
    } else {
      playVideo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: videoTapped,
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: 3 / 2,
                child: VideoPlayer(_controller),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
