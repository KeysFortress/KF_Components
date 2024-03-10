import 'package:domain/models/enums.dart';
import 'package:domain/models/otp_code.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:domain/models/stored_secret.dart';
import 'package:infrastructure/interfaces/iidentity_manager.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:infrastructure/interfaces/isync_service.dart';
import 'package:shared/component_base_model.dart';

class OneTimeDataPickerViewModel extends ComponentBaseModel {
  late ISecretManager _secretManager;
  late IIdentityManager _identityManager;
  late IOtpService _otpService;

  List<StoredIdentity> _identities = [];
  List<StoredIdentity> get identities => _identities;

  List<StoredSecret> _secrets = [];
  List<StoredSecret> get secrets => _secrets;

  List<OtpCode> _codes = [];
  List<OtpCode> get codes => _codes;

  ActiveNavigationPage _activeNavigationPage = ActiveNavigationPage.passwords;
  ActiveNavigationPage get selected => _activeNavigationPage;

  OneTimeDataPickerViewModel(super.context) {
    _identityManager = getIt.get<IIdentityManager>();
    _otpService = getIt.get<IOtpService>();
    _secretManager = getIt.get<ISecretManager>();
  }

  ready() async {
    _secrets = await _secretManager.getSecrets();
    notifyListeners();
  }

  getItemCount() {
    switch (_activeNavigationPage) {
      case ActiveNavigationPage.passwords:
        return _secrets.length;
      case ActiveNavigationPage.totp:
        if (_codes.isEmpty) {
          _otpService.get().then((value) {
            _codes = value;
            notifyListeners();
          });
        }
        return _codes.length;
      case ActiveNavigationPage.secrets:
      case ActiveNavigationPage.syncMode:
      case ActiveNavigationPage.identities:
        if (_identities.isEmpty) {
          _identityManager.getSecrets().then((value) {
            _identities = value;
            notifyListeners();
          });
        }
        return _identities.length;
    }
  }

  onTotpPressed() {
    _activeNavigationPage = ActiveNavigationPage.totp;
    notifyListeners();
  }

  onPasswordsPressed() {
    _activeNavigationPage = ActiveNavigationPage.passwords;
    notifyListeners();
  }

  onCertificatesPressed() {
    _activeNavigationPage = ActiveNavigationPage.identities;
    notifyListeners();
  }
}
