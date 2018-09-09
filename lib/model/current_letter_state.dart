import 'package:rxdart/subjects.dart';

class CurrentLetterState{

  BehaviorSubject<int> currentLetterIndexSubject;
  BehaviorSubject<int> swipeLetterSubject;

  CurrentLetterState() {
    currentLetterIndexSubject = new BehaviorSubject<int>();
    swipeLetterSubject = new BehaviorSubject<int>();
  }
}