import 'package:rxdart/subjects.dart';

class CurrentLetterState{

  BehaviorSubject<int> currentLetterIndexSubject;
  BehaviorSubject<int> swipeLetterSubject;

  CurrentLetterState() {
    currentLetterIndexSubject = BehaviorSubject<int>();
    swipeLetterSubject = BehaviorSubject<int>();
  }
}