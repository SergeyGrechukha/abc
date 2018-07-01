import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/view_model/upper_alphabet_view_model.dart';
import 'package:flutter/material.dart';

class UpperAlphabet extends StatelessWidget {

  static const ALPHABET_GRID_ID = 'alphabet_grid';
  static const AXIS_OFFSET = 3.0;
  static const EDGE_VERTICAL_OFFSET = 5.0;
  static const EDGE_HORIZONTAL_OFFSET = 10.0;

  final UpperAlphabetViewModel _viewModel;

  UpperAlphabet(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return builtAlphabet(context);
  }

  Widget buildLetterGridTile(LetterData letter, int index) {
    return Material(
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
    );
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
          if (_letters.isNotEmpty) {
            letterWidgets.add(_abcButton(_letters.length, _letters[0].color));
          }
          return buildContainer(context, letterWidgets);
        });
  }

  Container buildContainer(BuildContext context, List<Widget> letters) {
    final itemWidth =
        _getWidgetWidth(this._viewModel.isPortrait()) / _getColumnCount();
    final itemHeight = _getItemHeight();

    return Container(
      constraints: _buildBoxConstraints(context, _viewModel.isPortrait(), itemHeight),
      child: Center(
        child: GridView.count(
          key: Key(ALPHABET_GRID_ID),
          primary: false,
          padding: EdgeInsets.fromLTRB(
              EDGE_HORIZONTAL_OFFSET,
              EDGE_VERTICAL_OFFSET,
              EDGE_HORIZONTAL_OFFSET,
              EDGE_VERTICAL_OFFSET
          ),
          crossAxisSpacing: AXIS_OFFSET,
          mainAxisSpacing: AXIS_OFFSET,
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: _getColumnCount(),
          children: letters,
        ),
      ),
    );
  }

  double _getItemHeight() {
    if (_viewModel.letterDataSubject.value == null) {
      return 0.0;
    }
    var rowsAmount =
        _viewModel.letterDataSubject.value.length ~/ _getColumnCount();
    var remainder =
        _viewModel.letterDataSubject.value.length % _getColumnCount();
    if (remainder != 0) {
      rowsAmount++;
    }
    return (_getWidgetHeight(this._viewModel.isPortrait()) - EDGE_VERTICAL_OFFSET * 2) / rowsAmount
        - (this._viewModel.isPortrait() ? 0 : AXIS_OFFSET * 1.5);
  }

  int _getColumnCount() => _viewModel.isPortrait() ? 9 : 3;

  BoxConstraints _buildBoxConstraints(BuildContext context, bool isPortrait, double itemHeight) {
    return BoxConstraints.tightForFinite(
      width: _getWidgetWidth(isPortrait),
      height: _getWidgetHeight(isPortrait),
    );
  }

  double _getWidgetHeight(bool isPortrait) =>
      this._viewModel.size().height * (!isPortrait ? 1 : 0.21);

  double _getWidgetWidth(bool isPortrait) =>
      this._viewModel.size().width * (isPortrait ? 1 : 0.21);

  _onTileClicked(int i) {
    _viewModel.onNewLetterClicked(i);
  }

  Widget _abcButton(int length, Color buttonColor) {
    return GridTile(
        child: Material(
      color: buttonColor,
      child: InkWell(
        enableFeedback: true,
        splashColor: buttonColor.withOpacity(0.2),
        child: Container(
          child: Center(
            child: Text(
              "abc",
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ),
        ),
        onTap: () => _onTileClicked(length),
      ),
    ));
  }
}
