import 'package:infrastructure/interfaces/ipage_router_service.dart';
import 'package:shared/component_base_model.dart';

class CopyPasswordWarningBoxViewModel extends ComponentBaseModel {
  late IPageRouterService _routerService;

  Function onSaveCallback;
  Function? onCancelCallback;

  CopyPasswordWarningBoxViewModel(
      super.context, this.onSaveCallback, this.onCancelCallback) {
    _routerService = getIt.get<IPageRouterService>();
  }

  onCancelPressed() {
    onCancelCallback?.call();
    _routerService.dismissBar(pageContext);
  }

  onConfirmPressed() {
    onSaveCallback.call();
  }
}
