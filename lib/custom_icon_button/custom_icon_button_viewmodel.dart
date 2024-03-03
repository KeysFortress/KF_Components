import 'package:stacked/stacked.dart';

class CustomIconButtonViewModel extends BaseViewModel {
  bool _disableAnimation = true;
  bool get disableAnimation => _disableAnimation;
  ready(bool playAnim) {
    _disableAnimation = playAnim == false ? true : false;
    notifyListeners();
  }
}
