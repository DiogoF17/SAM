import 'package:flutter/material.dart';

import "../utils/utils.dart";
import "../loadAction/loadAction.dart";

class LoadingScreen extends StatefulWidget {
  final LoadAction loadAction;

  LoadingScreen(this.loadAction, {Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    widget.loadAction.execute(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(color: getAppThemeColor(), child: loadingScreen()));
  }
}
