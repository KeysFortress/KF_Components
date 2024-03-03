import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:shared/component_base_model.dart';

class PinCodePanelViewModel extends ComponentBaseModel {
  bool _isLocked = true;
  bool get isLocked => _isLocked;

  late IAuthorizationService _authorizationService;
  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;

  String _password = "";
  get password => _password;

  PinCodePanelViewModel(super.context) {
    _authorizationService = getIt.get<IAuthorizationService>();
  }

  ready() {
    _password = "";
    _isLocked = true;
    notifyListeners();
  }

  buttonPressed(int number) async {
    if (_password.length == 6) return;

    _password += number.toString();
    if (_password.length == 6) {
      var isValid = await _authorizationService.unlockPin(_password);
      if (!isValid) return;

      _password = "";
      _isLocked = false;
      notifyListeners();
      // ignore: use_build_context_synchronously
      router.changePage(
        "/passwords",
        pageContext,
        TransitionData(next: PageTransition.easeInAndOut),
      );
    }
    notifyListeners();
  }

  onRemovePressed() {
    _password = _password.substring(0, _password.length - 1);

    notifyListeners();
  }

  onChangeVisability() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }
}
