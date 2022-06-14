import 'package:audioplayers/audioplayers.dart';

import "../database/music.dart";

class BackgroundMusicController {
  List<Music> musics = [
    Music("music1", "https://luan.xyz/files/audio/ambient_c_motion.mp3"),
    Music("music2", "https://luan.xyz/files/audio/nasa_on_a_mission.mp3")
  ];
  int currentMusicPlaying = 0;

  AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;
  bool musicStarted = false;

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
