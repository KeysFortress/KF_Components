import 'package:components/authentication_failed/authentication_failed.dart';
import 'package:components/biometric_panel/biometric_panel_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BiometricPanel extends StatelessWidget {
  const BiometricPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BiometricPanelViewModel(context),
      builder: (context, viewModel, child) => viewModel.failedToAuthenticate
          ? AuthenticationFailed(onTryAgain: viewModel.onTryAgain)
          : const Column(
              children: [],
            ),
    );
  }
}
