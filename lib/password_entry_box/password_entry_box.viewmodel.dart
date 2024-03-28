import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/stored_secret.dart';
import 'package:infrastructure/interfaces/idevices_service.dart';
import 'package:infrastructure/interfaces/ilocal_storage.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:infrastructure/interfaces/isync_service.dart';
import 'package:shared/component_base_model.dart';

class PasswordEntryBoxViewModel extends ComponentBaseModel {
  late ISecretManager _secretManager;
  late IlocalStorage _storage;
  late ISyncService _syncService;
  late IDevicesService _devicesService;

  String _password = "";
  String get password => _password;
  String _name = "";
  String _email = "";

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

  bool _isSyncOnActionEnabled = false;

  PasswordEntryBoxViewModel(super.context) {
    _secretManager = getIt.get<ISecretManager>();
    _storage = getIt.get<IlocalStorage>();
    _syncService = getIt.get<ISyncService>();
    _devicesService = getIt.get<IDevicesService>();
  }

  ready(String current) async {
    _isSaving = false;
    _password = current;
    _passwordSize = password.length.toDouble();
    var syncSettings = await _syncService.getGlobalSettings();
    _isSyncOnActionEnabled =
        syncSettings['onAction'] && syncSettings['onPassword'];
    notifyListeners();
  }

  onNameChanged(String name) {
    _name = name;
  }

  onEmailChanged(String email) {
    _email = email;
  }

  Future onSave() async {
    validate();
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

    if (!result) {
      throw BaseException(
        context: pageContext,
        message: "Failed to save the password",
      );
    }

    _isCopyActionPresent = true;
    if (_isSyncOnActionEnabled) observer.getObserver("sync_changes", null);

    notifyListeners();
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

  validate() {
    if (_name.isEmpty) {
      throw BaseException(
          context: pageContext, message: "The name field is required");
    }
    if (_email.isEmpty) {
      throw BaseException(
          context: pageContext, message: "The email field is required");
    }
  }
}
