import 'dart:async';

import 'package:shared/component_base_model.dart';

class SecondsCounterViewModel extends ComponentBaseModel {
  int _seconds = 60;
  int get seconds => _seconds;

  SecondsCounterViewModel(super.context) {
    _seconds = DateTime.now().second;
    Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds = 60 - DateTime.now().second;

      notifyListeners();
    });
  }
  ready() {}
}
