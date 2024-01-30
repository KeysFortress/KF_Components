import 'package:domain/models/enums.dart';
import 'package:shared/page_view_model.dart';

class DesktopNavigationViewModel extends PageViewModel {
  Function pageChanged;

  DesktopNavigationViewModel(super.context, this.pageChanged);

  ActiveNavigationPage _selected = ActiveNavigationPage.passwords;
  ActiveNavigationPage get selected => _selected;

  onCloudSync() {}

  onPasswordsPressed() {
    pageChanged.call(ActiveNavigationPage.passwords);
  }

  onTotpPressed() {
    pageChanged.call(ActiveNavigationPage.totp);
  }

  onSecretsPressed() {
    pageChanged.call(ActiveNavigationPage.secrets);
  }

  onFidoPressed() {
    pageChanged.call(ActiveNavigationPage.identities);
  }
}
