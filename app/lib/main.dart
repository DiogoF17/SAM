import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(LittleLearner());
}

class LittleLearner extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  LittleLearner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Little Learner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
            future: _fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("You have an error! ${snapshot.error.toString()}");
                return Text("Something went wrong!");
              } else if (snapshot.hasData) {
                return const HomePage();
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
