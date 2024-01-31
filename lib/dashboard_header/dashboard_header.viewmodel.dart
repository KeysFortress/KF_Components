import 'package:domain/models/enums.dart';
import 'package:infrastructure/interfaces/iidentity_manager.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:shared/page_view_model.dart';

class DashboardHeaderViewModel extends PageViewModel {
  late ISecretManager _secretManager;
  late IIdentityManager _identityManager;
  late IOtpService _otpService;
  DashboardHeaderViewModel(super.context, ActiveNavigationPage type) {
    observer.subscribe("active_page_changed", pageChanged);
    _secretManager = getIt.get<ISecretManager>();
    _identityManager = getIt.get<IIdentityManager>();
    _otpService = getIt.get<IOtpService>();
    pageChanged(type);
  }

  int _totalSaved = 0;
  get saved => _totalSaved;

  String _lastUsed = "--";
  String get lastUsed => _lastUsed;

  pageChanged(ActiveNavigationPage page) async {
    switch (page) {
      case ActiveNavigationPage.passwords:
        loadPasswords();
      case ActiveNavigationPage.syncMode:
      // TODO: Handle this case.
      case ActiveNavigationPage.identities:
        loadIdentities();
      case ActiveNavigationPage.totp:
        loadTotp();
      case ActiveNavigationPage.secrets:
      // TODO: Handle this case.
    }
  }

  void loadIdentities() async {
    var secrets = await _identityManager.getSecrets();
    _totalSaved = secrets.length;

    _lastUsed =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    notifyListeners();
  }

  void loadPasswords() async {
    var secrets = await _secretManager.getSecrets();
    _totalSaved = secrets.length;
    secrets.sort((a, b) => a.lastUsed.isAfter(b.lastUsed) == true ? 1 : 0);
    var lastDate = secrets.first.lastUsed;
    _lastUsed = "${lastDate.day}/${lastDate.month}/${lastDate.year}";
    notifyListeners();
  }

  void loadTotp() async {
    var otp = await _otpService.get();
    _totalSaved = otp.length;
    var lastDate = DateTime.now();
    _lastUsed = "${lastDate.day}/${lastDate.month}/${lastDate.year}";
    notifyListeners();
  }
}
