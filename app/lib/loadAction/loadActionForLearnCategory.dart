import 'package:flutter/material.dart';

import "./loadAction.dart";

import "../database/database.dart";
import "../database/media.dart";
import "../database/category.dart";

import "../utils/utils.dart";
import "../utils/mediaController.dart";

import "../pages/learnSpecificCategory.dart";

class LoadActionForLearnCategory extends LoadAction {
  final Category category;

  LoadActionForLearnCategory(this.category);

  @override
  void execute(BuildContext context) async {
    List<Media> media = await loadMedia(category);
    MediaController mediaController = MediaController(category, media, 5);

    replaceCurrentPage(context, LearnSpecificCategoryPage(mediaController));
  }
}
