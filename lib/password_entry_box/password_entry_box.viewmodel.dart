import 'package:domain/models/enums.dart';
import 'package:domain/models/stored_secret.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:shared/component_base_model.dart';

class PasswordEntryBoxViewModel extends ComponentBaseModel {
  late ISecretManager _secretManager;
  late IlocalStorage _storage;

  String _password = "";
  String get password => _password;
  late String _name;
  late String _email;

  bool _isAdvanced = false;
  bool get isAdvanced => _isAdvanced;
  double _passwordSize = 8;
  double get passwordSize => _passwordSize;

  bool _isSpecialAllowed = true;
  bool get isSpecialAllowed => _isSpecialAllowed;

  bool _isDigit = true;
  bool get isDigit => _isDigit;
  bool _isLower = true;
  bool get isLower => _isLower;
  bool _isUpper = true;
  bool get isUpper => _isUpper;
  bool _isUnique = true;
  bool get isUnique => _isUnique;
  bool _isCopyActionPresent = false;
  bool get isCopyActionPresent => _isCopyActionPresent;
  bool _isSaving = false;

  PasswordEntryBoxViewModel(super.context) {
    _secretManager = getIt.get<ISecretManager>();
    _storage = getIt.get<IlocalStorage>();
  }

  ready(String current) {
    _password = current;
    _passwordSize = password.length.toDouble();
    notifyListeners();
  }

  onNameChanged(String name) {
    _name = name;
  }

  onEmailChanged(String email) {
    _email = email;
  }

  Future onSave() async {
    if (_isSaving) return;

    _isSaving = true;
    var id = await _storage.generateId();
    var result = await _secretManager.setSecret(
      StoredSecret(
        id: id,
        name: _name,
        username: _email,
        content: password,
        lastUsed: DateTime.now(),
        secretType: SecretType.password,
      ),
    );

    if (result) {
      _isCopyActionPresent = true;
      notifyListeners();
    }
  }

  onAdvancedPressed() {
    _isAdvanced = !_isAdvanced;
    notifyListeners();
  }

  void onSizeChanged(double value) {
    _passwordSize = value;

    generatePassword();
    notifyListeners();
  }

  void onAllowSpecialChaged(bool value) {
    _isSpecialAllowed = !_isSpecialAllowed;
    generatePassword();
    notifyListeners();
  }

  void onIsUniqueChanged(bool value) {
    _isUnique = !_isUnique;
    generatePassword();
    notifyListeners();
  }

  void onAllowLowerChanged(bool value) {
    _isLower = !_isLower;
    generatePassword();
    notifyListeners();
  }

  void onIsDigitChanged(bool value) {
    _isDigit = !_isDigit;
    generatePassword();
    notifyListeners();
  }

  void onIsUpperChanged(bool value) {
    _isUpper = !_isUpper;
    generatePassword();
    notifyListeners();
  }

  void generatePassword() {
    _password = _secretManager.generateSecret(
      length: _passwordSize.toInt(),
      isDigit: _isDigit,
      isLower: _isLower,
      isUpper: _isUpper,
      isUnique: _isUnique,
      isSecial: _isSpecialAllowed,
    );

    observer.getObserver("on_sync_event", null);
  }

  applyLenght(double value) {
    _passwordSize = value;
    generatePassword();
    notifyListeners();
  }

  onConfirmCopy(String password) async {
    await _secretManager.copySensitiveData(password);
    observer.getObserver(
      "reload_passwords",
      null,
    );
  }
}
