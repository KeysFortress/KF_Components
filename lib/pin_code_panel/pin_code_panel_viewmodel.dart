import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:shared/component_base_model.dart';

class PinCodePanelViewModel extends ComponentBaseModel {
  late IAuthorizationService _authorizationService;
  late IPageRouterService _routerService;

  bool _isLocked = true;
  bool get isLocked => _isLocked;

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;

  String _password = "";
  get password => _password;

  PinCodePanelViewModel(super.context) {
    _authorizationService = getIt.get<IAuthorizationService>();
    _routerService = getIt.get<IPageRouterService>();
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

      if (!isValid) {
        _password = "";
        observer.getObserver("unlock_failed", null);
        notifyListeners();
        return;
      }

      _routerService.isLocked = false;
      _password = "";
      _isLocked = false;
      notifyListeners();
      router.changePage(
        "/dashboard",
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
