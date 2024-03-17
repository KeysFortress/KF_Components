import 'package:components/biometric_panel/biometric_panel_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class BiometricPanel extends StatelessWidget {
  const BiometricPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => BiometricPanelViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => const Column(
        children: [],
      ),
    );
  }
}
