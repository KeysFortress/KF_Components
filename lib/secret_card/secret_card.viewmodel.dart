import 'package:domain/models/stored_secret.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:shared/component_base_model.dart';

class SecretCardViewModel extends ComponentBaseModel {
  StoredSecret storedSecret;
  late ISecretManager _secretManager;
  SecretCardViewModel(super.context, this.storedSecret) {
    _secretManager = getIt.get<ISecretManager>();
  }

  onCopyPressed() {
    _secretManager.copySensitiveData(storedSecret.content);
  }
}
