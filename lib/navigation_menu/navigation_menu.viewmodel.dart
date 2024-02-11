import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:shared/component_base_model.dart';

class NavigationMenuViewModel extends ComponentBaseModel {
  ActiveNavigationPage _selected = ActiveNavigationPage.passwords;
  ActiveNavigationPage get selected => _selected;

  NavigationMenuViewModel(super.context, ActiveNavigationPage currentPage) {
    _selected = currentPage;
  }

  onPasswordsPressed() {
    _selected = ActiveNavigationPage.passwords;

    router.changePage(
      "/passwords",
      pageContext,
      TransitionData(
        next: PageTransition.slideBack,
      ),
    );
  }

  onCertificatesPressed() {
    _selected = ActiveNavigationPage.identities;
    notifyListeners();

    router.changePage(
      "/identities",
      pageContext,
      TransitionData(
        next: PageTransition.slideForward,
      ),
    );
  }

  onTotpPressed() {
    observer.getObserver("on_menu_state_changed", false);
    router.changePage(
      "/totp",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
    );
  }
}
