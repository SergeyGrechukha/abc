import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/view_model/upper_alphabet_view_model.dart';
import 'package:flutter/material.dart';

class UpperAlphabet extends StatelessWidget {

  static const ALPHABET_GRID_ID = 'alphabet_grib';
  final UpperAlphabetViewModel _viewModel;

  UpperAlphabet(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return builtAlphabet(context);
  }

  GridTile buildLetterGridTile(LetterData letter, int index) {
    return GridTile(
        child: Material(
      color: letter.color,
      child: InkWell(
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
    return StreamBuilder(
        stream: _viewModel.letterDataSubject.stream,
        initialData: _viewModel.letterDataSubject.value ?? [],
        builder: (_, AsyncSnapshot<List<LetterData>> data) {
          var _letters = data.data ?? [];
          List<Widget> letterWidgets = new List();
          for (int i = 0; i < _letters.length; i++) {
            letterWidgets.add(buildLetterGridTile(_letters.elementAt(i), i));
          }
          return buildContainer(context, letterWidgets);
        });
  }

  Container buildContainer(BuildContext context, List<Widget> letters) {
    return Container(
      constraints: buildBoxConstraints(context, _viewModel.isPortrait()),
      child: Center(
        child: GridView.count(
          key: Key(ALPHABET_GRID_ID),
          primary: false,
          padding: const EdgeInsets.all(10.0),
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
          crossAxisCount: _viewModel.isPortrait() ? 9 : 3,
          children: letters,
        ),
      ),
    );
  }

  BoxConstraints buildBoxConstraints(BuildContext context, bool isPortrait) {
    return BoxConstraints(
      minWidth: this._viewModel.size().width * (isPortrait ? 1 : 0.21),
      maxWidth: this._viewModel.size().width * (isPortrait ? 1 : 0.21),
      maxHeight: this._viewModel.size().height * (!isPortrait ? 1 : 0.21),
      minHeight: this._viewModel.size().height * (!isPortrait ? 1 : 0.21),
    );
  }

  _onTileClicked(int i) {
    _viewModel.onNewLetterClicked(i);
  }
}
