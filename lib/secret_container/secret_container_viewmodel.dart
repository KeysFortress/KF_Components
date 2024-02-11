import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:shared/component_base_model.dart';

class SecretContainerViewModel extends ComponentBaseModel {
  late ISecretManager _secretManager;
  SecretContainerViewModel(super.context) {
    _secretManager = getIt.get<ISecretManager>();
  }

  onCopyValue(String value) {
    _secretManager.copySensitiveData(value);
  }
}
