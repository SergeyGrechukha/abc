import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class FireBaseRepository {
  BehaviorSubject<List<DocumentSnapshot>> _lettersDocumentsSubject;

  FireBaseRepository() {
    this._lettersDocumentsSubject = new BehaviorSubject<List<DocumentSnapshot>>();

        Firestore.instance.collection('letters').snapshots()
        .map((snapshot) => snapshot?.documents ?? [])
        .listen((documents) => _lettersDocumentsSubject.add(documents));
  }

  BehaviorSubject<List<DocumentSnapshot>> get lettersDocumentsSubject =>
      _lettersDocumentsSubject;
}
