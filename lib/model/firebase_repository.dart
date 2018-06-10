import 'package:abc/model/data_classes/letter_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class FireBaseRepository {
  BehaviorSubject<List<LetterData>> _lettersSubject;

  FireBaseRepository() {
    this._lettersSubject = BehaviorSubject<List<LetterData>>();
    Firestore.instance
        .collection('letters')
        .snapshots()
        .map((snapshot) => _mapToListOfLetters(snapshot))
        .listen((letters) => _lettersSubject.add(letters));
  }

  List<LetterData> _mapToListOfLetters(QuerySnapshot snapshot) {
    var documents = snapshot?.documents ?? [];
    List<LetterData> letters =
        documents.map((snapshot) => LetterData.from(snapshot)).toList();
    letters.sort((a, b) => a.letter.compareTo(b.letter));
    return letters;
  }

  Observable<List<LetterData>> getLettersStream() {
    return this._lettersSubject.stream;
  }


  List<LetterData> getLatestValue() {
    return this._lettersSubject.value;
  }
}
