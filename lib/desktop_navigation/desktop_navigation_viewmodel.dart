import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:shared/component_base_model.dart';

class DesktopNavigationViewModel extends ComponentBaseModel {
  DesktopNavigationViewModel(super.context);

  ActiveNavigationPage _selected = ActiveNavigationPage.passwords;
  ActiveNavigationPage get selected => _selected;

  onCloudSync() {}

  onPasswordsPressed() {
    router.changePage(
      "/passwords",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }

  onTotpPressed() {
    router.changePage(
      "/totp",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }

  onSecretsPressed() {
    router.changePage(
      "/passwords",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }

  onFidoPressed() {
    router.changePage(
      "/identities",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
    );
  }
}
