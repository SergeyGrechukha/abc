import 'package:abc/pages/home_page.dart';
import 'package:abc/utils/custom_tts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


void main() async {
  await FirebaseAuth.instance.signInAnonymously();

  runApp(new MyApp());
  await CustomTts.setLanguage("en-US");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ABooC. Alphabet for ghosts',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'ABooC. Ghosts\' Alphabet'),
    );
  }
}




