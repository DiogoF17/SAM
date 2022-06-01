import '../database/media.dart';
import '../database/category.dart';
import '../utils/sequence.dart';

import "dart:math";

class MediaController {
  Category category;

  List<Media> media = [];

  late Sequence sequence;

  MediaController(this.category, this.media, int sequenceSize) {
    sequence = Sequence(sequenceSize, media.length);
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

  Media getTargetMedia() {
    return media[sequence.getCurrentValueInSequence()];
  }

  List<Media> getDifferentTypesOfMedia(
      List<Media> currMedia, int numberOfMedia) {
    List<Media> copyOfMedia = [...media];

    var random = Random();

    int missingNumberOfMedia = numberOfMedia - currMedia.length;
    while (missingNumberOfMedia > 0 && copyOfMedia.isNotEmpty) {
      int generatedIndex = random.nextInt(copyOfMedia.length);
      Media selectedMedia = copyOfMedia[generatedIndex];

      copyOfMedia.removeAt(generatedIndex);

      if (isNewMediaType(selectedMedia, currMedia)) {
        currMedia.add(selectedMedia);
        missingNumberOfMedia--;
      }
    }

    return currMedia;
  }

  bool isNewMediaType(Media newMedia, List<Media> oldMedia) {
    for (Media aux in oldMedia) {
      if (aux.name == newMedia.name) return false;
    }

    return true;
  }
}
