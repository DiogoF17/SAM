import 'package:flutter/material.dart';
import "../utils/backgroundMusicController.dart";

abstract class LoadAction {
  BackgroundMusicController backgroundMusicController;

  LoadAction(this.backgroundMusicController);

  void execute(BuildContext context);
}
