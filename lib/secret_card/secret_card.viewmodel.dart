import 'package:components/copy_password_warning_box/copy_password_warning_box.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/stored_secret.dart';
import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:infrastructure/interfaces/isecret_manager.dart';
import 'package:shared/component_base_model.dart';

class SecretCardViewModel extends ComponentBaseModel {
  StoredSecret storedSecret;
  late ISecretManager _secretManager;
  late IPageRouterService _routerService;

  SecretCardViewModel(super.context, this.storedSecret) {
    _secretManager = getIt.get<ISecretManager>();
    _routerService = getIt.get<IPageRouterService>();
  }

  onCopyPressed() {
    _routerService.openDialog(
      CopyPasswordWarningBox(
          onSaveCallback: onSave, entryType: PasswordWarningBoxType.general),
      pageContext,
    );
  }

  onSave() async {
    await _secretManager.copySensitiveData(storedSecret.content);
    // ignore: use_build_context_synchronously
    _routerService.dismissBar(pageContext);
  }
}
