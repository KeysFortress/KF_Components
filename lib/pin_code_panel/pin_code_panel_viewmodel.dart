import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:shared/page_view_model.dart';

class PinCodePanelViewModel extends PageViewModel {
  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;

  String _password = "";
  get password => _password;

  PinCodePanelViewModel(super.context);

  buttonPressed(int number) {
    if (_password.length == 6) return;

    _password += number.toString();
    if (_password.length == 6) {
      _password = "";
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
