import 'package:abc/model/letter_data.dart';
import 'package:abc/my_cover_flow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

class AlphabetSlider extends StatelessWidget {

  final BehaviorSubject positionSubject;
  final List<LetterData> letters;

  AlphabetSlider(this.positionSubject, this.letters);

  @override
  Widget build(BuildContext context) {
    var coverFlow = CoverFlow(
      dismissibleItems: false,
      itemCount: letters.length,
      itemBuilder: (_, int index) {
        return Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: new BoxDecoration(
              border: new Border.all(
                color: Colors.blue,
                width: 4.0,
              ),
            ),
            child: Center(
              child: new FadeInImage(
                  fadeInDuration: Duration(milliseconds: 350),
                  image: new NetworkImage(letters[index].imageUrl),
                  placeholder:
                  new AssetImage(LetterData.defaultImageUrl)),
            ),
          ),
        );
      },
    );
    var state = coverFlow.state;
    positionSubject.listen((position) => state.scrollToPosition(position));
    return coverFlow;
  }
}
