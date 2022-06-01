import 'package:flutter/material.dart';

import "./loadAction.dart";

import "../database/database.dart";
import "../database/image.dart";
import "../database/sound.dart";
import "../database/category.dart";

import "../utils/utils.dart";
import "../utils/mediaController.dart";

import "../pages/learnSpecificCategory.dart";

class LoadActionForLearnCategory extends LoadAction {
  final Category category;

  LoadActionForLearnCategory(this.category);

  @override
  void execute(BuildContext context) async {
    List<MyImage> media = await loadMedia(category);
    MediaController mediaController = MediaController(category, media, 5);

    if (mediaController.hasSounds()) {
      List<Sound> sounds = await loadSounds(category);
      mediaController.setSounds(sounds);
    }

    replaceCurrentPage(context, LearnSpecificCategoryPage(mediaController));
  }
}
