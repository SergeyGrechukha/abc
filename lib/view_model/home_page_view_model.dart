import 'dart:ui';

import 'package:abc/model/current_letter_state.dart';
import 'package:abc/model/firebase_repository.dart';
import 'package:abc/view_model/base_firebase_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class HomePageViewModel extends BaseFireBaseViewModel {
  static const Color DEFAULT_COLOR = Color(0xffc83f3f);
  final CurrentLetterState _currentState;
  BehaviorSubject _colorSubject;

  HomePageViewModel(FireBaseRepository fireBaseRepository, this._currentState)
      : super(fireBaseRepository) {
    _colorSubject = BehaviorSubject<Color>();
    Observable
        .combineLatest2(
            letterDataSubject,
            _currentState.swipeLetterSubject,
            (letters, index) => letters[index].color)
        .forEach((color) => _colorSubject.add(color));
  }

  BehaviorSubject get colorSubject => _colorSubject;
}
