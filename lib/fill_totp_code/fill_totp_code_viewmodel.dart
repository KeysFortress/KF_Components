import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:shared/page_view_model.dart';

class FillTotpCodeViewModel extends PageViewModel {
  late IAuthorizationService _authorizationService;
  FillTotpCodeViewModel(super.context) {
    _authorizationService = getIt.get<IAuthorizationService>();
  }

  onCodeChanged(String code) async {
    if (code.length < 6) return;

    var match = await _authorizationService.unlockTotp(code);
    if (!match) return;

    // ignore: use_build_context_synchronously
    router.changePage(
      "/passwords",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
    );
  }
}
