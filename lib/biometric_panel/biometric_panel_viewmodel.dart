import 'package:domain/exceptions/base_exception.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/models/transition_data.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared/component_base_model.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class BiometricPanelViewModel extends ComponentBaseModel {
  final LocalAuthentication auth = LocalAuthentication();
  bool _failedToAuthenticate = false;
  bool get failedToAuthenticate => _failedToAuthenticate;
  BiometricPanelViewModel(super.context);

  ready() async {
    await requestBiometric();
  }

  Future requestBiometric() async {
    try {
      await auth.stopAuthentication();

      var result = await auth.authenticate(
        localizedReason: 'Please authenticate to unlock the application',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          biometricOnly: true,
        ),
      );

      if (result) {
        router.isLocked = false;
        router.changePage(
          "/passwords",
          // ignore: use_build_context_synchronously
          pageContext,
          TransitionData(next: PageTransition.slideForward),
        );
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        _failedToAuthenticate = true;
        throw BaseException(
          // ignore: use_build_context_synchronously
          context: pageContext,
          message: e.message,
        );
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
        _failedToAuthenticate = true;
        throw BaseException(
          // ignore: use_build_context_synchronously
          context: pageContext,
          message: e.message,
        );
      } else {
        _failedToAuthenticate = true;
        throw BaseException(
          // ignore: use_build_context_synchronously
          context: pageContext,
          message: e.message,
        );
      }
    }
    notifyListeners();
  }

  onTryAgain() async {
    _failedToAuthenticate = false;
    notifyListeners();
    await requestBiometric();
  }
}
