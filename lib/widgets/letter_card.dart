import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/utils/custom_tts.dart';
import 'package:flutter/material.dart';


///Single letter card with Letter, image and say button
class LetterCard extends StatelessWidget{

  final LetterData letter;

  LetterCard(this.letter);

  @override
  Widget build(BuildContext context) {
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
                child: _buildImageWidget(this.letter)),
            Positioned(
              right: 0.0,
              bottom: 0.0,
              child: IconButton(
                color: this.letter.color,
                icon: Icon(
                    IconData(0xea26, fontFamily: 'Icons')
                ),
                onPressed: () => _say(this.letter),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(LetterData letter) {
    return Center(
      child: new FadeInImage(
          fadeInDuration: Duration(milliseconds: 150),
          image: new NetworkImage(letter.imageUrl),
          placeholder: new AssetImage(LetterData.defaultImageUrl)),
    );
  }

  _say(LetterData letter) async {
    var speakLetter = letter.letter.toLowerCase() == 'z' ? 'Zat' : letter.letter;
    CustomTts.speak('$speakLetter. is for ${letter.word}');
  }

}