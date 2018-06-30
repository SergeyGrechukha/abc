import 'package:abc/custom/my_cover_flow.dart';
import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/view_model/slider_view_model.dart';
import 'package:flutter/material.dart';
import 'package:abc/widgets/letter_card.dart';
import 'package:abc/widgets/abc_card.dart';

class AlphabetSlider extends StatelessWidget {

  final SliderViewModel _viewModel;

  AlphabetSlider(this._viewModel);

  @override
  Widget build(BuildContext context) {
    print('recreating');
    return StreamBuilder(
      stream: _viewModel.letterDataSubject.stream,
      initialData: _viewModel.letterDataSubject.value ?? [],
      builder: (_, AsyncSnapshot<List<LetterData>> snapshot) {
        var _letters = snapshot.data ?? [];
        var coverFlow = CoverFlow(
          initialPositionIndex: 0,
          viewportFraction: .8,
          dismissibleItems: false,
          itemCount: _letters.length + 1,
          currentLetterState:  _viewModel.currentState,
          itemBuilder: (_, int index) {
            return index < _letters.length ? LetterCard(_letters[index]) : AbcCard(_letters, _viewModel.isPortrait());
          },
        );
        var state = coverFlow.state;
        _viewModel.getLetterIndexSubject().listen((position) => state.scrollToPosition(position));
        return coverFlow;
      },
    );
  }


}
