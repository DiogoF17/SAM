import '../database/image.dart';
import '../database/sound.dart';
import '../database/category.dart';
import '../utils/sequence.dart';

import "dart:math";

class MediaController {
  Category category;

  List<MyImage> media = [];
  List<Sound> sounds = [];

  late Sequence sequence;

  MediaController(this.category, this.media, int sequenceSize) {
    sequence = Sequence(sequenceSize, media.length);
  }

  void setSounds(List<Sound> sounds_) {
    sounds = sounds_;
  }

  bool hasSounds() {
    return sounds.isNotEmpty;
  }

  String getPathOfCurrentSound() {
    String soundId = getTargetMedia().soundId;

    for (Sound sound in sounds) {
      if (sound.id == soundId) return sound.path;
    }

    return "";
  }

  String getCategoryName() {
    return category.name;
  }

  void goToNextMedia() {
    sequence.goToNextValueInSequence();
  }

  void goToPreviousMedia() {
    sequence.goToPreviousValueInSequence();
  }

  bool isFirstMedia() {
    return sequence.isFirstValueInSequence();
  }

  bool isLastMedia() {
    return sequence.isLastValueInSequence();
  }

  MyImage getTargetMedia() {
    return media[sequence.getCurrentValueInSequence()];
  }

  List<MyImage> getDifferentTypesOfMedia(
      List<MyImage> currMedia, int numberOfMedia) {
    List<MyImage> copyOfMedia = [...media];

    var random = Random();

    int missingNumberOfMedia = numberOfMedia - currMedia.length;
    while (missingNumberOfMedia > 0 && copyOfMedia.isNotEmpty) {
      int generatedIndex = random.nextInt(copyOfMedia.length);
      MyImage selectedMedia = copyOfMedia[generatedIndex];

      copyOfMedia.removeAt(generatedIndex);

      if (isNewMediaType(selectedMedia, currMedia)) {
        currMedia.add(selectedMedia);
        missingNumberOfMedia--;
      }
    }

    return currMedia;
  }

  bool isNewMediaType(MyImage newMedia, List<MyImage> oldMedia) {
    for (MyImage aux in oldMedia) {
      if (aux.name == newMedia.name) return false;
    }

    return true;
  }
}
