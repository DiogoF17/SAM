import 'package:flutter/material.dart';

import "./loadAction.dart";

import "../database/database.dart";
import "../database/category.dart";

import "../utils/utils.dart";
import "../utils/backgroundMusicController.dart";

import "../pages/playCategories.dart";

class LoadActionForPlayCategories extends LoadAction {
  LoadActionForPlayCategories(
      BackgroundMusicController backgroundMusicController)
      : super(backgroundMusicController);

  @override
  void execute(BuildContext context) async {
    List<Category> categories = await loadCategories();

    replaceCurrentPage(
        context, PlayCategoriesPage(categories, backgroundMusicController));
  }
}
