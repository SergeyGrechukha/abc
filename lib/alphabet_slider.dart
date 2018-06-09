import 'package:abc/model/letter_data.dart';
import 'package:abc/my_cover_flow.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:tts/tts.dart';

class AlphabetSlider extends StatelessWidget {
  final BehaviorSubject positionSubject;
  final List<LetterData> letters;
  final bool isPortrait;

  AlphabetSlider(this.positionSubject, this.isPortrait, this.letters);

  @override
  Widget build(BuildContext context) {
    var coverFlow = CoverFlow(
      dismissibleItems: false,
      itemCount: letters.length,
      itemBuilder: (_, int index) {
        return Card(
          elevation: 4.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              border: new Border.all(
                color: Colors.blue,
                width: 4.0,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                    right: isPortrait ? 0.0 : null,
                    left: isPortrait ? 0.0 : null,
                    top:  !isPortrait ? 0.0 : null,
                    bottom:  !isPortrait ? 0.0 : null,
                    child: buildImageWidget(index)),
                Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: RaisedButton(
                    child: Text('Say me'),
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
          fadeInDuration: Duration(milliseconds: 350),
          image: new NetworkImage(letters[index].imageUrl),
          placeholder: new AssetImage(LetterData.defaultImageUrl)),
    );
  }

  _say(LetterData letter) {
    Tts.speak(letter.word);
  }
}
