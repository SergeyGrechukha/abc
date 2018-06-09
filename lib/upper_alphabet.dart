import 'package:abc/model/letter_data.dart';
import 'package:flutter/material.dart';

class UpperAlphabet extends StatelessWidget {
  final LetterChanged _onLetterChanged;
  final bool _isPortrait;
  final List<LetterData> letters;

  UpperAlphabet(this._onLetterChanged, this._isPortrait, this.letters);

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
          child: Center(
            child: Text(
              letter.letter.toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        onTap: () => _onTileClicked(index),
      ),
    ));
  }

  Widget builtAlphabet(BuildContext context) {
    List<Widget> letterWidgets = new List();
    for (int i = 0; i < letters.length; i++) {
      letterWidgets.add(buildLetterGridTile(letters.elementAt(i), i));
    }
    return buildContainer(context, letterWidgets);
  }

  Container buildContainer(BuildContext context, List<Widget> letters) {
    return Container(
      constraints: buildBoxConstraints(context, _isPortrait),
      child: Center(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10.0),
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
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
  void onSwiped(int letterIndex);
}
