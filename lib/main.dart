import 'package:abc/model/current_letter_state.dart';
import 'package:abc/model/firebase_repository.dart';
import 'package:abc/pages/home_page.dart';
import 'package:abc/pages/letter_details_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

void main() async {
  var user = await FirebaseAuth.instance.signInAnonymously();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final FireBaseRepository _fireBaseRepository;
  final CurrentLetterState _currentState;

  MyApp()
      : _fireBaseRepository = new FireBaseRepository(),
        _currentState = new CurrentLetterState();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Alphabet',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(_fireBaseRepository, _currentState, title: 'Alphabet'),
      routes: getRoutes(),
    );
  }

  getRoutes() {

    return <String, WidgetBuilder>{
      '/details': (BuildContext context) {
        Size preferredSize = new Size.fromHeight(kToolbarHeight);
        var screenSize = MediaQuery.of(context).size;
        var size = new Size(screenSize.width, screenSize.height - preferredSize.height - (Platform.isAndroid ? 24 : 0));
        return new DetailsPage(_fireBaseRepository, _currentState, size);
      }
    };
  }
}
