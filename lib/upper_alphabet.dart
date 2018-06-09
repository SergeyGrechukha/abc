import 'package:abc/model/letter_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpperAlphabet extends StatelessWidget {
  final LetterChanged _onLetterChanged;
  final bool _isPortrait;

  UpperAlphabet(this._onLetterChanged, this._isPortrait);

  @override
  Widget build(BuildContext context) {
    return builtAlphabet(context);
  }

  GridTile buildLetterGridTile(LetterData letter, int index) {
    return new GridTile(
        child: new Material(
      color: letter.color,
      child: new InkWell(
        enableFeedback: true,
        splashColor: Colors.amber,
        child: Container(
          decoration: new BoxDecoration(
            border: new Border.all(
              color: Colors.blue,
              width: 1.0,
            ),
          ),
          child: Center(
            child: Text(letter.letter),
          ),
        ),
        onTap: () => _onTileClicked(index),
      ),
    ));
  }

  Widget builtAlphabet(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('letters').snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          var documents = snapshot.data?.documents ?? [];
          var letters =
              documents.map((snapshot) => LetterData.from(snapshot)).toList();
          letters.sort((a, b) => a.letter.compareTo(b.letter));
          List<Widget> letterWidgets = new List();
          for (int i = 0; i < letters.length; i++) {
            letterWidgets.add(buildLetterGridTile(letters.elementAt(i), i));
          }
          return buildContainer(context, letterWidgets);
        });
  }

  Container buildContainer(BuildContext context, List<Widget> letters) {
    return Container(
      constraints: buildBoxConstraints(context, _isPortrait),
      child: Center(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10.0),
          crossAxisSpacing: 3.0,
          crossAxisCount: _isPortrait ? 9 : 3,
          children: letters,
        ),
      ),
    );
  }

  BoxConstraints buildBoxConstraints(BuildContext context, bool isPortrait) {
    return BoxConstraints(
      minWidth: MediaQuery.of(context).size.width * (isPortrait ? 1 : 0.21),
      maxWidth: MediaQuery.of(context).size.width * (isPortrait ? 1 : 0.21),
      maxHeight: MediaQuery.of(context).size.height * (!isPortrait ? 1 : 0.21),
      minHeight: MediaQuery.of(context).size.height * (!isPortrait ? 1 : 0.21),
    );
  }

  _onTileClicked(int i) {
    if (_onLetterChanged != null) {
      _onLetterChanged.onLetterChanged(i);
    }
    print('Letter index = $i');
  }
}

abstract class LetterChanged {
  void onLetterChanged(int letterIndex);
}