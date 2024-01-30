import 'package:domain/models/enums.dart';
import 'package:shared/page_view_model.dart';

class DesktopNavigationViewModel extends PageViewModel {
  DesktopNavigationViewModel(super.context);

  ActiveNavigationPage _selected = ActiveNavigationPage.passwords;
  ActiveNavigationPage get selected => _selected;

  onCloudSync() {}

  onPasswordsPressed() {}

  onTotpPressed() {}

  onCertificatesPressed() {}
}
