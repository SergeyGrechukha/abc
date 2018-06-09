import 'package:flutter/material.dart';

class UpperAlphabet extends StatelessWidget {

  final LetterChanged _onLetterChanged;

  UpperAlphabet(this._onLetterChanged);

  @override
  Widget build(BuildContext context) {
    int charA = 'a'.codeUnitAt(0);
    const int ALPHABET_LENGTH = 26;
    List<Widget> letters = new List();
    for (int i = 0; i < ALPHABET_LENGTH; i++) {
      letters.add(new GridTile(
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
            child: Text(new String.fromCharCode(charA + i)),
          ),
        ),
        onTap: () => _onTileClicked(i),
      )));
    }

    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height * 0.21,
        minHeight: MediaQuery.of(context).size.height * 0.21,
      ),
      child: Center(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10.0),
          crossAxisSpacing: 3.0,
          crossAxisCount: 9,
          children: letters,
        ),
      ),
    );
  }

  _onTileClicked(int i) {
    if (_onLetterChanged != null) {
      _onLetterChanged.onLetterChanged(i);
    }
    print('Letter index = $i');
  }
}

abstract class LetterChanged{
  void onLetterChanged(int letterIndex);
}
