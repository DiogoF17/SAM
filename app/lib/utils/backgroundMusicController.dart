import 'package:app/database/database.dart';
import 'package:audioplayers/audioplayers.dart';

import "../database/music.dart";

class BackgroundMusicController {
  List<Music> musics = [];
  int currentMusicPlaying = 0;

  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;
  bool musicStarted = false;

  BackgroundMusicController(){
    loadMusic();
  }

  void loadMusic () async {
    musics = await loadMusics();
    musics.sort((a, b) => a.name.compareTo(b.name));
    play();
  }

  void play() {
    if (!validMusic(currentMusicPlaying) || isPlaying) return;

    isPlaying = true;

    if (musicStarted) {
      resume();
    } else {
      playFromStart();
    }
  }

  void playFromStart() {
    musicStarted = true;
    audioPlayer.play(musics[currentMusicPlaying].path);
    audioPlayer.onPlayerCompletion.listen((event) {
      playFromStart();
    });
  }

  void resume() {
    audioPlayer.resume();
  }

  void pause() {
    if (!isPlaying) return;

    isPlaying = false;
    audioPlayer.pause();
  }

  void changeToMusic(int musicNumber) {
    if (!validMusic(musicNumber)) return;

    currentMusicPlaying = musicNumber;
    playFromStart();
  }

  bool validMusic(int musicNumber) {
    return musicNumber >= 0 && musicNumber < musics.length;
  }
}
