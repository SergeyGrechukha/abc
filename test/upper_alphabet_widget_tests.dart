import 'dart:math';

import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/view_model/upper_alphabet_view_model.dart';
import 'package:abc/widgets/upper_alphabet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/subjects.dart';

void main() {

  var mockViewModel = new UpperAlphabetViewModelMock();
  List<LetterData> letters = [
    LetterData('a', 'url', 'a_word', Colors.red),
    LetterData('b', 'url', 'b_word', Colors.green),
    LetterData('c', 'url', 'c_word', Colors.blue),
  ];

  var letterSubject = BehaviorSubject<List<LetterData>>(seedValue: letters);

  when(mockViewModel.letterDataSubject).thenReturn(letterSubject);
  when(mockViewModel.size()).thenReturn(Size(500.0, 500.0));
  when(mockViewModel.isPortrait()).thenReturn(true);


  UpperAlphabet testedWidget = UpperAlphabet(mockViewModel);

  testWidgets('Test amount of shown letters', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: testedWidget));

     expect(find.byWidgetPredicate((widget) => widget is GridTile), findsNWidgets(letters.length));
  });

  testWidgets('Test alphabet letters content', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: testedWidget));
    for (var value in letters) {
      expect(find.text(value.letter.toUpperCase()), findsOneWidget);
    }
  });

  testWidgets('Test letters click', (WidgetTester tester) async {
    await tester.pumpWidget(new MaterialApp(home: testedWidget));
    var letter = letters[Random().nextInt(letters.length - 1)];
    tester.tap(find.text(letter.letter.toUpperCase()));
    await untilCalled(mockViewModel.onNewLetterClicked(letters.indexOf(letter)));
  });
}

class UpperAlphabetViewModelMock extends Mock implements UpperAlphabetViewModel{}
