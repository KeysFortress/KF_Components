import 'package:shared/component_base_model.dart';

class CustomSliderViewModel extends ComponentBaseModel {
  double _value = 1;
  double get value => _value;

  CustomSliderViewModel(super.context);

  ready(double initialValue) {
    _value = initialValue;
  }

  void onSizeChanged(double current) {
    _value = current;
    notifyListeners();
  }
}
