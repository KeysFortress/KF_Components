import 'package:components/pattern_panel/pattern_panel_viewmodel.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import 'package:stacked/stacked.dart';

class PatternPanel extends StatelessWidget {
  const PatternPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PatternPanelViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => viewModel.isLocked
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.background200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SizedBox(
                    height: ThemeStyles.height! / 2,
                    child: PatternLock(
                      selectedColor: ThemeStyles.theme.primary300,
                      pointRadius: 8,
                      showInput: true,
                      dimension: 3,
                      relativePadding: 0.7,
                      selectThreshold: 25,
                      fillPoints: true,
                      onInputComplete: (List<int> input) =>
                          viewModel.onPatternFilled(input),
                    ),
                  ),
                ),
              ],
            )
          : const Column(),
    );
  }
}
