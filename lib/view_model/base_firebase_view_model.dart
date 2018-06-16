import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/model/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseFireBaseViewModel {
  final FireBaseRepository fireBaseRepository;
  BehaviorSubject<List<LetterData>> letterDataSubject;

  BaseFireBaseViewModel(this.fireBaseRepository) {
    letterDataSubject = BehaviorSubject<List<LetterData>>();
    this
        .fireBaseRepository
        .lettersDocumentsSubject
        .map((documents) => _mapToListOfLetters(documents))
        .where((list) => list.isNotEmpty)
        .listen((letters) => letterDataSubject.add(letters));
  }

  List<LetterData> _mapToListOfLetters(List<DocumentSnapshot> documents) {
    List<LetterData> letters =
        documents.map((snapshot) => LetterData.from(snapshot)).toList();
    letters.sort((a, b) => a.letter.compareTo(b.letter));
    return letters;
  }

  getStream() => letterDataSubject.stream;
}
