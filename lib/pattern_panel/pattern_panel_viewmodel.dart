import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:shared/page_view_model.dart';

class PatternPanelViewModel extends PageViewModel {
  late IAuthorizationService _authorizationService;
  PatternPanelViewModel(super.context) {
    _authorizationService = getIt.get<IAuthorizationService>();
  }

  onPatternFilled(List<int> input) async {
    var patternMatch = await _authorizationService.unlockPattern(input);
    if (!patternMatch) return;

    // ignore: use_build_context_synchronously
    router.changePage(
      "/passwords",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
    );
  }
}
