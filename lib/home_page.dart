import 'package:abc/alphabet_slider.dart';
import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/model/firebase_repository.dart';
import 'package:abc/upper_alphabet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final FireBaseRepository _fireBaseRepository = new FireBaseRepository();

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements LetterChanged {
  final _positionSubject = BehaviorSubject<int>();
  static const Color DEFAULT_COLOR = Color(0xffc83f3f);
  List<LetterData> letters;
  Color _appBarColor = DEFAULT_COLOR;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: _appBarColor,
        title: Center(
          child: new Text(widget.title),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return StreamBuilder(
              stream: widget._fireBaseRepository.getLettersStream(),
              builder: (_, AsyncSnapshot<List<LetterData>> snapshot) {
                letters = snapshot.data ?? [];
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
    _updateColor(letterIndex);
  }

  void _updateColor(int letterIndex) {
    this.currentPage = letterIndex;
    setState(() {
      _appBarColor = letters != null && letters.isNotEmpty
          ? letters[letterIndex].color
          : DEFAULT_COLOR;
    });
  }

  @override
  void onSwiped(int letterIndex) {
    _updateColor(letterIndex);
  }

  Widget getOrientedWidget(bool isPortrait, List<LetterData> letters) {
    var upperAlphabet = UpperAlphabet(this, isPortrait, letters);
    var slider = Expanded(
      child: AlphabetSlider(_positionSubject, isPortrait, letters, this.currentPage, this),
    );
    return isPortrait
        ? Container(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            child: Column(
              children: <Widget>[upperAlphabet, slider],
            ),
          )
        : Row(
            children: <Widget>[upperAlphabet, slider],
          );
  }
}
