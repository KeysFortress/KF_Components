import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:shared/component_base_model.dart';

class KeybaordMenuViewModel extends ComponentBaseModel {
  KeybaordMenuViewModel(super.context);

  onPasswordsPressed() {
    router.changePage(
      "/passwords",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
    );
  }

  onTotpPressed() {
    router.changePage(
      "/totp",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
    );
  }

  onIdentitiesPressed() {
    router.changePage(
      "/identities",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
    );
  }
}
