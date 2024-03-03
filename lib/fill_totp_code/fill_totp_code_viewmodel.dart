import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:shared/page_view_model.dart';

class FillTotpCodeViewModel extends PageViewModel {
  bool _isLocked = true;
  bool get isLocked => _isLocked;
  late IAuthorizationService _authorizationService;
  FillTotpCodeViewModel(super.context) {
    _authorizationService = getIt.get<IAuthorizationService>();
    _isLocked = true;
  }

  ready() {
    _isLocked = true;
    notifyListeners();
  }

  onCodeChanged(String code) async {
    if (code.length < 6) return;

    var match = await _authorizationService.unlockTotp(code);
    if (!match) return;

    _isLocked = false;
    notifyListeners();
    // ignore: use_build_context_synchronously
    router.changePage(
      "/passwords",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
    );
  }
}
