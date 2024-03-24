import 'package:domain/models/otp_code.dart';
import 'package:infrastructure/interfaces/iotp_service.dart';
import 'package:shared/component_base_model.dart';

class TotpCardViewModel extends ComponentBaseModel {
  late IOtpService _otpService;

  String _code = "";
  String get code => _code;

  String _address = "";
  String get address => _address;

  String _issuer = "";
  String get issuer => _issuer;

  late OtpCode _otpCode;

  TotpCardViewModel(super.context, OtpCode otpCode) {
    _otpCode = otpCode;
    _otpService = getIt.get<IOtpService>();
  }

  ready() {
    _code = _otpService.getCode(_otpCode.secret, _otpCode.interval ?? 30);
    _address = _otpCode.address;
    _issuer = _otpCode.issuer;
    notifyListeners();
  }
}
