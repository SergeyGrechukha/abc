import 'package:abc/model/current_letter_state.dart';
import 'package:abc/model/data_classes/letter_data.dart';
import 'package:abc/model/firebase_repository.dart';
import 'package:abc/view_model/base_firebase_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class SliderViewModel extends BaseFireBaseViewModel {
  final CurrentLetterState _currentState;

  SliderViewModel(FireBaseRepository fireBaseRepository, this._currentState)
      : super(fireBaseRepository);

  BehaviorSubject<int> getLetterIndexSubject() {
    return _currentState.currentLetterIndexSubject;
  }

  CurrentLetterState get currentState => _currentState;
}
