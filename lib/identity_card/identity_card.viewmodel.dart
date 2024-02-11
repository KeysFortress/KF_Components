import 'package:domain/models/enums.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:domain/models/transition_data.dart';
import 'package:shared/component_base_model.dart';

import '../manual_sign_box.dart/manual_sign_box.dart';

class IdentityCardViewModel extends ComponentBaseModel {
  StoredIdentity identity;

  IdentityCardViewModel(super.context, this.identity);

  onConnectPressed() {
    router.changePage(
      "/start-auth",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
      bindingData: identity,
    );
  }

  onSave() {
    router.dismissBar(pageContext);
  }

  onManualSignPressed() {
    router.openBar(
      ManualSignBox(identity: identity, onSave: onSave),
      pageContext,
    );
  }

  viewHistory() {
    router.changePage(
      "/identity-history",
      pageContext,
      TransitionData(next: PageTransition.slideForward),
      bindingData: identity,
    );
  }
}
