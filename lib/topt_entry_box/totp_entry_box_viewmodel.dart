import 'package:domain/models/otp_code.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:shared/component_base_model.dart';

class TotpEntryBoxViewModel extends ComponentBaseModel {
  late IOtpService _otpService;
  OtpCode? _code;
  OtpCode? get code => _code;
  Function? onSaveCallback;
  TotpEntryBoxViewModel(super.context, this.onSaveCallback) {
    _otpService = getIt.get<IOtpService>();
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

    return _otpService.getCode(_code!.code);
  }

  void onSave() async {
    if (_code == null) return;

    await _otpService.add(_code!);

    observer.getObserver("on_sync_event", null);
    // ignore: use_build_context_synchronously
    if (onSaveCallback == null) router.backToPrevious(pageContext);
    onSaveCallback?.call();
  }
}
