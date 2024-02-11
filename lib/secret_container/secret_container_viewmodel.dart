import 'package:flutter/services.dart';
import 'package:shared/component_base_model.dart';

class SecretContainerViewModel extends ComponentBaseModel {
  SecretContainerViewModel(super.context);

  onCopyValue(String value) {
    Clipboard.setData(
      ClipboardData(
        text: value,
      ),
    );
  }
}
