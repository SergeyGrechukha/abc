import 'package:abc/model/current_letter_state.dart';
import 'package:abc/model/firebase_repository.dart';
import 'package:abc/view_model/home_page_view_model.dart';
import 'package:abc/view_model/slider_view_model.dart';
import 'package:abc/view_model/upper_alphabet_view_model.dart';
import 'package:abc/widgets/alphabet_slider.dart';
import 'package:abc/widgets/upper_alphabet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final FireBaseRepository _fireBaseRepository;
  final CurrentLetterState _currentState;

  MyHomePage(this._fireBaseRepository, this._currentState, {Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState(new HomePageViewModel(_fireBaseRepository, _currentState));
}

class _MyHomePageState extends State<MyHomePage>  {

  Color _appBarColor = HomePageViewModel.DEFAULT_COLOR;

  Widget _currentContent;
  Widget _currentSlider;
  bool _isPortrait = true;
  final HomePageViewModel _viewModel;


  _MyHomePageState(this._viewModel);

  @override
  Widget build(BuildContext context) {
    _currentSlider = getSlider();

    _viewModel.colorSubject.listen((color) => setState(() {
          _appBarColor = color;
        }));

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: _appBarColor,
        title: Center(
          child: new Text(widget.title),
        ),
      ),
      body: getOrientedWidget(),
    );
  }

  Container buildLoadingWidget() => Container();

  Widget getOrientedWidget() {
    return OrientationBuilder(
      builder: (context, orientation) {
        var isPortrait = orientation == Orientation.portrait;
        if (this._isPortrait != isPortrait || this._currentContent == null) {
          this._isPortrait = isPortrait;
          var upperAlphabet = UpperAlphabet(new UpperAlphabetViewModel(
              widget._fireBaseRepository,
              widget._currentState,
              MediaQuery.of(context)));
          this._currentContent = isPortrait
              ? Container(
                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                  child: Column(
                    children: <Widget>[upperAlphabet, this._currentSlider],
                  ),
                )
              : Row(
                  children: <Widget>[upperAlphabet, this._currentSlider],
                );
        }
        return _currentContent;
      },
    );
  }

  Widget getSlider() {
    return Expanded(
      child: AlphabetSlider(
          new SliderViewModel(widget._fireBaseRepository, widget._currentState)),
    );
  }
}
