import 'package:components/authentication_failed/authentication_failed.dart';
import 'package:components/biometric_panel/biometric_panel_viewmodel.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BiometricPanel extends StatelessWidget {
  const BiometricPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BiometricPanelViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => viewModel.failedToAuthenticate
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: ThemeStyles.height! / 3,
                  child: AuthenticationFailed(
                    onTryAgain: viewModel.onTryAgain,
                  ),
                ),
              ],
            )
          : const Column(
              children: [],
            ),
    );
  }
}
