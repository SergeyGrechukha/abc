import 'package:flutter/material.dart';

class UpperAlphabet extends StatelessWidget {

  final LetterChanged _onLetterChanged;
  final bool _isPortrait;

  UpperAlphabet(this._onLetterChanged, this._isPortrait);

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

abstract class LetterChanged{
  void onLetterChanged(int letterIndex);
}
