import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/utils/custom_tts.dart';
import 'package:flutter/material.dart';

///Card with whole abc on it
class AbcCard extends StatelessWidget{

  final List<LetterData> letters;
  final bool isPortrait;

  AbcCard(this.letters, this.isPortrait);

  @override
  Widget build(BuildContext context) {
    List<Widget> letterWidgets = new List();
    for (int i = 0; i < this.letters.length; i++) {
      letterWidgets.add(buildLetterGridTile(this.letters.elementAt(i), i));
    }
    return buildContainer(context, letterWidgets);
  }

  Widget buildContainer(BuildContext context, List<Widget> letters) {
    return Card(
      elevation: 8.0,
      child: Center(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10.0),
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
          crossAxisCount: this.isPortrait ? 5 : 7,
          children: letters,
        ),
      ),
    );
  }


  GridTile buildLetterGridTile(LetterData letter, int index) {
    return GridTile(
        child: Material(
          child: InkWell(
            enableFeedback: true,
            splashColor: letter.color.withOpacity(0.2),
            child: Container(
              child: Center(
                child: Text(
                  letter.letter.toUpperCase(),
                  style: TextStyle(
                      color: letter.color,
                      fontSize: 24.0,
                      fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            onTap: () => _onTileClicked(letter),
          ),
        ));
  }

  _onTileClicked(LetterData letter) {
    CustomTts.speak(letter.letter.toLowerCase() == 'z' ? 'Zat' : letter.letter);
  }
}