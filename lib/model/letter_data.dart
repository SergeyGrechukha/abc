import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class LetterData {
  String letter;
  String imageUrl;
  String word;
  Color color;
  static final String defaultImageUrl = 'default.png';

  LetterData(this.letter, this.imageUrl, this.word, this.color);

  factory LetterData.from(DocumentSnapshot document) {
    return new LetterData(document.data['letter'], document.data['url'],
        document.data['word'], Color(_hexToInt(document.data['color'])));
  }

  static int _hexToInt(String hex) {
    if (hex == null || hex.isEmpty) {
      print('no color value');
      return 0xFFFFFF;
    }
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        print('Invalid hexadecimal value');
        return 0xFFFFFF;
      }
    }
    return val;
  }
}