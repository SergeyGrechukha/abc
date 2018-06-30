import 'dart:math';

import 'package:abc/model/current_letter_state.dart';
import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/model/firebase_repository.dart';
import 'package:abc/view_model/details_view_model.dart';
import 'package:abc/view_model/home_page_view_model.dart';
import 'package:abc/widgets/dragable_letter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final FireBaseRepository _fireBaseRepository;
  final CurrentLetterState _currentState;
  final DetailsViewModel _viewModel;
  final Size _size;

  DetailsPage(this._fireBaseRepository, this._currentState, this._size)
      : _viewModel = new DetailsViewModel(_fireBaseRepository, _currentState);

  @override
  State<StatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final _random = new Random();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget._viewModel.letterDataSubject.stream,
      builder: (_, AsyncSnapshot<List<LetterData>> snapshot) {
        var _letters = snapshot.data ?? [];
        var _letterIndex = widget._currentState.swipeLetterSubject.value ?? 0;
        //todo check for empty list
        var currentLetter = _letters.isNotEmpty ? _letters[_letterIndex] : null;
        return new Scaffold(
          appBar: new AppBar(
            backgroundColor: currentLetter != null
                ? currentLetter.color
                : HomePageViewModel.DEFAULT_COLOR,
            title: Center(
              //todo remove hardcode
              child: new Text("Alphabet"),
            ),
          ),
          body: getContentWidget(context, _letters, _letterIndex),
        );
      },
    );
  }

  Widget getContentWidget(
      BuildContext context, List<LetterData> letters, int currentLetterIndex) {
    Size letterContainerSize =
        new Size.square(widget._size.width * 0.3);

    List<Widget> stackWidgets = [];
    if (letters.isNotEmpty) {
      Set<String> pureImageUrls = Set<String>();
      pureImageUrls.add(letters[currentLetterIndex].pureImageUrl);
      do {
        var index = _random.nextInt(letters.length);
        pureImageUrls.add(letters[index].pureImageUrl);
      } while (pureImageUrls.length < 4);
      stackWidgets = getQuizeImages(
          pureImageUrls, letterContainerSize, letters[currentLetterIndex]);
    }

    return Stack(
      children: stackWidgets,
    );
  }

  List<Widget> getQuizeImages(Set<String> pureImageUrls,
      Size letterContainerSize, LetterData currentLetter) {
    List<Widget> stackWidgets = [];
    List<String> shuffled = pureImageUrls.toList();
    shuffle(shuffled);

    Widget letter = DraggableLetter(
        new Offset(widget._size.width / 2 - letterContainerSize.width / 2,
            widget._size.height / 2 - letterContainerSize.height / 2),
        letterContainerSize,
        currentLetter);
    stackWidgets.add(letter);
    for (var i = 0; i < 4; i++) {
      var position = _getPosition(i, letterContainerSize);
      Widget imageWidget = Positioned(
        left: position.x,
        top: position.y,
        child: DragTarget<LetterData>(
          onWillAccept: (data) => Random().nextBool(),
          onAccept: (data) => print('DATA = $data'),
          builder: (BuildContext context, List<dynamic> accepted,
              List<dynamic> rejected) {
            return Opacity(
              opacity: 0.8,
              child: Container(
                width: letterContainerSize.width,
                height: letterContainerSize.height,
                child: Center(
                  child: new FadeInImage(
                      fadeInDuration: Duration(milliseconds: 150),
                      image: new NetworkImage(shuffled.elementAt(i)),
                      placeholder: new AssetImage(LetterData.defaultImageUrl)),
                ),
              ),
            );
          },
        ),
      );
      stackWidgets.add(imageWidget);
    }
    return stackWidgets;
  }

  getLetterWidget(Size letterContainerSize, LetterData letter) {
    return Container(
      width: letterContainerSize.width,
      height: letterContainerSize.height,
      child: Center(
        child: Text(
          letter.letter.toUpperCase(),
          style: TextStyle(
            color: letter.color,
            fontSize: letterContainerSize.height * 0.6,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }


  Point<double> _getPosition(int i, Size letterContainerSize) {
    double x, y;
    switch (i) {
      case 0:
        x = widget._size.width / 2 - letterContainerSize.width / 2;
        y = widget._size.height / 2 - 3 * letterContainerSize.height / 2;
        break;
      case 1:
        x = widget._size.width / 2 - 3 * letterContainerSize.width / 2;
        y = widget._size.height / 2 - letterContainerSize.height / 2;
        break;
      case 2:
        x = widget._size.width / 2 + letterContainerSize.width / 2;
        y = widget._size.height / 2 - letterContainerSize.height / 2;
        break;
      case 3:
        x = widget._size.width / 2 - letterContainerSize.width / 2;
        y = widget._size.height / 2 + letterContainerSize.height / 2;
        break;
    }
    return new Point(x, y);
  }
}
