import 'package:cloud_firestore/cloud_firestore.dart';

class LetterData{
  String letter;
  String imageUrl;
  String word;
  static final String defaultImageUrl = 'default.png';

  LetterData(this.letter, this.imageUrl, this.word);

  factory LetterData.from(DocumentSnapshot document) {
  return new LetterData(
    document.data['letter'],
    document.data['url'],
    document.data['word']
  );
}
}