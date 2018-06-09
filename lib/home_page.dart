import 'package:abc/alphabet_slider.dart';
import 'package:abc/upper_alphabet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements LetterChanged {
  final _positionSubject = BehaviorSubject<int>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Center(
          child: new Text(widget.title),
        ),
      ),
      body: Column(
        children: <Widget>[
          UpperAlphabet(this),
          Expanded(
            child: AlphabetSlider(_positionSubject),
          )
        ],
      ),
    );
  }

  @override
  void onLetterChanged(int letterIndex) {
    _positionSubject.add(letterIndex);
  }
}
