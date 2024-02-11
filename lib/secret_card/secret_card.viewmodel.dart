import 'package:domain/models/stored_secret.dart';
import 'package:flutter/services.dart';
import 'package:shared/component_base_model.dart';

class SecretCardViewModel extends ComponentBaseModel {
  StoredSecret storedSecret;
  SecretCardViewModel(super.context, this.storedSecret);

  onCopyPressed() {
    Clipboard.setData(
      ClipboardData(
        text: storedSecret.content,
      ),
    );
  }
}
