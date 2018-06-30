import 'package:abc/model/current_letter_state.dart';
import 'package:abc/model/firebase_repository.dart';
import 'package:abc/view_model/base_firebase_view_model.dart';

class DetailsViewModel extends BaseFireBaseViewModel {

  final CurrentLetterState _currentState;

  DetailsViewModel(FireBaseRepository fireBaseRepository, this._currentState)
      : super(fireBaseRepository);
}
