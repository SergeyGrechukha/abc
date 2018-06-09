import 'package:abc/alphabet_slider.dart';
import 'package:abc/model/letter_data.dart';
import 'package:abc/upper_alphabet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: OrientationBuilder(
        builder: (context, orientation) {
          return StreamBuilder(
              stream: Firestore.instance.collection('letters').snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                var documents = snapshot.data?.documents ?? [];
                var letters = documents
                    .map((snapshot) => LetterData.from(snapshot))
                    .toList();
                letters.sort((a, b) => a.letter.compareTo(b.letter));
                return getOrientedWidget(
                    orientation == Orientation.portrait, letters);
              });
        },
      ),
    );
  }

  @override
  void onLetterChanged(int letterIndex) {
    _positionSubject.add(letterIndex);
  }

  Widget getOrientedWidget(bool isPortrait, List<LetterData> letters) {
    var upperAlphabet = UpperAlphabet(this, isPortrait, letters);
    var slider = Expanded(
      child: AlphabetSlider(_positionSubject, isPortrait, letters),
    );
    return isPortrait
        ? Column(
            children: <Widget>[upperAlphabet, slider],
          )
        : Row(
            children: <Widget>[upperAlphabet, slider],
          );
  }
}
