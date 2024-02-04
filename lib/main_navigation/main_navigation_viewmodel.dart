import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:shared/page_view_model.dart';

class MainNavigationViewModel extends PageViewModel {
  MainNavigationViewModel(super.context);

  onMenuPressed() {}

  onSharePressed() {
    router.changePage(
      "/connect-devices",
      pageContext,
      TransitionData(next: PageTransition.easeInAndOut),
    );
  }
}
