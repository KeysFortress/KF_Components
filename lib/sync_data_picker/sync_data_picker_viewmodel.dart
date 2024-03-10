import 'package:domain/models/enums.dart';
import 'package:domain/models/otp_code.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:domain/models/stored_secret.dart';
import 'package:infrastructure/interfaces/iidentity_manager.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:infrastructure/interfaces/isync_service.dart';
import 'package:shared/component_base_model.dart';
import 'package:domain/models/selectable_exchange_data.dart';

class SyncDataPickerViewModel extends ComponentBaseModel {
  late ISecretManager _secretManager;
  late IIdentityManager _identityManager;
  late IOtpService _otpService;
  late ISyncService _syncService;
  late String _deviceId;
  late Function _onSave;

  SelectableExchangeData _exchangeData = SelectableExchangeData([], [], []);
  SelectableExchangeData get exchangeData => _exchangeData;
  List<StoredIdentity> _identities = [];
  List<StoredIdentity> get identities => _identities;

  List<StoredSecret> _secrets = [];
  List<StoredSecret> get secrets => _secrets;
  List<OtpCode> _codes = [];
  List<OtpCode> get codes => _codes;

  ActiveNavigationPage _activeNavigationPage = ActiveNavigationPage.passwords;
  ActiveNavigationPage get selected => _activeNavigationPage;

  SyncDataPickerViewModel(super.context, String deviceId, Function onSelected) {
    _secretManager = getIt.get<ISecretManager>();
    _identityManager = getIt.get<IIdentityManager>();
    _otpService = getIt.get<IOtpService>();
    _syncService = getIt.get<ISyncService>();
    _deviceId = deviceId;
    _onSave = onSelected;
  }

  ready() async {
    _exchangeData = await _syncService.getPartialData(_deviceId);
    _secrets = await _secretManager.getSecrets();
    notifyListeners();
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

  onSecretSelected(int index) {
    if (_exchangeData.secrets
        .any((element) => element.id == _secrets.elementAt(index).id)) {
      _exchangeData.secrets
          .removeWhere((element) => element.id == _secrets.elementAt(index).id);
      notifyListeners();
      return;
    }

    _exchangeData.secrets.add(_secrets.elementAt(index));
    notifyListeners();
  }

  onCodeSelected(int index) {
    if (_exchangeData.otpCodes
        .any((element) => element.id == _codes.elementAt(index).id)) {
      _exchangeData.otpCodes
          .removeWhere((element) => element.id == _codes.elementAt(index).id);
      notifyListeners();
      return;
    }

    _exchangeData.otpCodes.add(_codes.elementAt(index));
    notifyListeners();
  }

  onIdentitySelected(int index) {
    if (_exchangeData.identities
        .any((element) => element.id == _identities.elementAt(index).id)) {
      _exchangeData.identities.removeWhere(
          (element) => element.id == _identities.elementAt(index).id);
      notifyListeners();
      return;
    }

    _exchangeData.identities.add(_identities.elementAt(index));
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

  onSavePressed() async {
    await _syncService.setPatrialSyncOptions(
      _deviceId,
      _exchangeData.secrets.map((e) => e.id).toList(),
      _exchangeData.identities.map((e) => e.id).toList(),
      _exchangeData.otpCodes.map((e) => e.id).toList(),
    );
    // ignore: use_build_context_synchronously
    router.dismissBar(pageContext);
    _onSave.call();
  }
}
