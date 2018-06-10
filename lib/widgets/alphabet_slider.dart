import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/custom/my_cover_flow.dart';
import 'package:abc/widgets/upper_alphabet.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:tts/tts.dart';

class AlphabetSlider extends StatelessWidget {
  final BehaviorSubject positionSubject;
  final List<LetterData> letters;
  final bool isPortrait;
  final LetterChanged swipeListener;
  final int initialPositionIndex;

  AlphabetSlider(this.positionSubject, this.isPortrait, this.letters, this.initialPositionIndex, this.swipeListener);

  @override
  Widget build(BuildContext context) {
    var coverFlow = CoverFlow(
      initialPositionIndex: initialPositionIndex,
      viewportFraction: .8,
      dismissibleItems: false,
      itemCount: letters.length,
      swipeListener: swipeListener,
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
                    child: buildImageWidget(index)),
                Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: IconButton(
                    color: letters[index].color,
                    icon: Icon(
                        IconData(0xea26, fontFamily: 'Icons')
                    ),
                    onPressed: () => _say(letters[index]),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
    var state = coverFlow.state;
    positionSubject.listen((position) => state.scrollToPosition(position));
    return coverFlow;
  }

  Widget buildImageWidget(int index) {
    return Center(
      child: new FadeInImage(
          fadeInDuration: Duration(milliseconds: 150),
          image: new NetworkImage(letters[index].imageUrl),
          placeholder: new AssetImage(LetterData.defaultImageUrl)),
    );
  }

  _say(LetterData letter) {
    Tts.speak(letter.word);
  }
}
