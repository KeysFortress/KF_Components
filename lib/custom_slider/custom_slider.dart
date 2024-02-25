import 'package:components/custom_slider/custom_slider_viewmodel.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CustomSlider extends StatelessWidget {
  final double initialValue;
  final double maxValue;
  final int divisios;
  final Function slidingStopped;

  const CustomSlider({
    super.key,
    required this.initialValue,
    required this.maxValue,
    required this.divisios,
    required this.slidingStopped,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CustomSliderViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(initialValue),
      builder: (context, viewModel, child) => Slider(
        value: viewModel.value,
        max: maxValue,
        label: viewModel.value.toInt().toString(),
        divisions: divisios,
        activeColor: ThemeStyles.theme.primary300,
        inactiveColor: ThemeStyles.theme.primary200,
        onChanged: viewModel.onSizeChanged,
        onChangeEnd: (value) => slidingStopped.call(value),
      ),
    );
  }
}
