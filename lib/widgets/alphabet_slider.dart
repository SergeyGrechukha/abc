import 'package:abc/custom/my_cover_flow.dart';
import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/view_model/slider_view_model.dart';
import 'package:flutter/material.dart';


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
          itemCount: _letters.length,
          currentLetterState:  _viewModel.currentState,
          itemBuilder: (_, int index) {
            return Card(
              elevation: 8.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        right: 0.0,
                        left: 0.0,
                        top: 0.0,
                        bottom: 0.0,
                        child: buildImageWidget(_letters[index])),
                    Positioned(
                      right: 0.0,
                      bottom: 0.0,
                      child: IconButton(
                        color: _letters[index].color,
                        icon: Icon(
                            IconData(0xea26, fontFamily: 'Icons')
                        ),
                        onPressed: () => _viewModel.say(_letters[index]),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
        var state = coverFlow.state;
        _viewModel.getLetterIndexSubject().listen((position) => state.scrollToPosition(position));
        return coverFlow;
      },
    );
  }

  Widget buildImageWidget(LetterData letter) {
    return Center(
      child: new FadeInImage(
          fadeInDuration: Duration(milliseconds: 150),
          image: new NetworkImage(letter.imageUrl),
          placeholder: new AssetImage(LetterData.defaultImageUrl)),
    );
  }
}
