import 'package:abc/model/current_letter_state.dart';
import 'package:abc/model/firebase_repository.dart';
import 'package:abc/view_model/base_firebase_view_model.dart';
import 'package:flutter/material.dart';

class UpperAlphabetViewModel extends BaseFireBaseViewModel{

  final MediaQueryData _mediaQueryData;
  final CurrentLetterState _currentState;

  UpperAlphabetViewModel(FireBaseRepository fireBaseRepository, this._currentState, this._mediaQueryData) : super(fireBaseRepository);

  CurrentLetterState get currentState => _currentState;

  Size size() {
    return _mediaQueryData.size;
  }

  bool isPortrait() {
    return _mediaQueryData.orientation == Orientation.portrait;
  }

  onNewLetterClicked(int index) {
    _currentState.currentLetterIndexSubject.add(index);
  }

}