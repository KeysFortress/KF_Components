import 'package:components/seconds_counter/seconds_counter_viewmodel.dart';
import 'package:domain/models/otp_code.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SecoondsCounter extends StatelessWidget {
  final OtpCode otpCode;
  const SecoondsCounter({super.key, required this.otpCode});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SecondsCounterViewModel(context, otpCode),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ThemeStyles.theme.accent100,
        ),
        child: Text(
          viewModel.seconds.toString(),
          style: ThemeStyles.regularParagraph,
        ),
      ),
    );
  }
}
