import 'package:domain/models/otp_code.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:infrastructure/interfaces/isync_service.dart';
import 'package:shared/component_base_model.dart';

class TotpEntryBoxViewModel extends ComponentBaseModel {
  late IOtpService _otpService;
  late ISyncService _syncService;
  OtpCode? _code;
  OtpCode? get code => _code;
  Function? onSaveCallback;

  bool _isSyncOnTotpEnabled = true;

  TotpEntryBoxViewModel(super.context, this.onSaveCallback) {
    _otpService = getIt.get<IOtpService>();
    _syncService = getIt.get<ISyncService>();
  }

  ready() async {
    var settings = await _syncService.getGlobalSettings();
    _isSyncOnTotpEnabled = settings["onAction"] && settings["onTotp"];
  }

  onLinkChanged(String link) {
    try {
      _code = OtpCode.fromQrCodeLink(link);
    } catch (ex) {
      _code = null;
    }
    notifyListeners();
  }

  String getCode() {
    if (_code == null) return "--";

    return _otpService.getCode(_code!.code, _code!.interval ?? 30);
  }

  void onSave() async {
    if (_code == null) return;

    await _otpService.add(_code!);

    if (_isSyncOnTotpEnabled) observer.getObserver("sync_changes", null);

    // ignore: use_build_context_synchronously
    if (onSaveCallback == null) router.backToPrevious(pageContext);
    onSaveCallback?.call();
  }
}
