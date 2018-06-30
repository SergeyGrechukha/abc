import 'package:abc/model/current_letter_state.dart';
import 'package:abc/model/firebase_repository.dart';
import 'package:abc/view_model/base_firebase_view_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class SliderViewModel extends BaseFireBaseViewModel {
  final CurrentLetterState _currentState;
  final MediaQueryData _mediaQueryData;

  SliderViewModel(FireBaseRepository fireBaseRepository, this._currentState, this._mediaQueryData)
      : super(fireBaseRepository);

  BehaviorSubject<int> getLetterIndexSubject() {
    return _currentState.currentLetterIndexSubject;
  }

  bool isPortrait() => this._mediaQueryData.orientation == Orientation.portrait;

  CurrentLetterState get currentState => _currentState;
}
