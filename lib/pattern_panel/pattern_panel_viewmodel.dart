import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:infrastructure/interfaces/iauthorization_service.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:shared/component_base_model.dart';

class PatternPanelViewModel extends ComponentBaseModel {
  late IAuthorizationService _authorizationService;
  late IPageRouterService _routerService;

  PatternPanelViewModel(super.context) {
    _authorizationService = getIt.get<IAuthorizationService>();
    _routerService = getIt.get<IPageRouterService>();
  }

  onPatternFilled(List<int> input) async {
    var patternMatch = await _authorizationService.unlockPattern(input);
    if (!patternMatch) {
      observer.getObserver("unlock_failed", null);
      return;
    }
    _routerService.isLocked = false;

    notifyListeners();
    router.changePage(
      "/dashboard",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
    );
  }
}
