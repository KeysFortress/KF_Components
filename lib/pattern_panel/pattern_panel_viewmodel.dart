import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:shared/component_base_model.dart';

class PatternPanelViewModel extends ComponentBaseModel {
  late IAuthorizationService _authorizationService;
  late IPageRouterService _routerService;

  bool _patternFailed = false;
  bool get patternFailed => _patternFailed;

  PatternPanelViewModel(super.context) {
    _authorizationService = getIt.get<IAuthorizationService>();
    _routerService = getIt.get<IPageRouterService>();
  }

  ready() {
    notifyListeners();
  }

  onPatternFilled(List<int> input) async {
    var patternMatch = await _authorizationService.unlockPattern(input);
    if (!patternMatch) {
      _patternFailed = true;
      notifyListeners();
      return;
    }
    _routerService.isLocked = false;

    notifyListeners();
    // ignore: use_build_context_synchronously
    router.changePage(
      "/passwords",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
    );
  }

  onTryAgain() {
    _patternFailed = false;
    notifyListeners();
  }
}
