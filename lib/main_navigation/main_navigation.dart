import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../custom_button/custom_button.dart';
import 'main_navigation_viewmodel.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MainNavigationViewModel(context),
      builder: (context, viewModel, child) => Container(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        color: ThemeStyles.theme.background300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 160,
              decoration: BoxDecoration(
                color: ThemeStyles.theme.background200,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: CustomButton(
                callback: viewModel.onMenuPressed,
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      "assets/images/settings.svg",
                      package: "domain",
                      width: 19.16,
                      height: 37.33,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        ThemeStyles.theme.primary300,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Settings",
                      style: ThemeStyles.whiteParagraph,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(
                color: ThemeStyles.theme.background200,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: CustomButton(
                callback: viewModel.onConnectPressed,
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Pair",
                      style: ThemeStyles.whiteParagraph,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    SvgPicture.asset(
                      "assets/images/sync.svg",
                      package: 'domain',
                      width: 19.16,
                      height: 37.33,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        ThemeStyles.theme.primary300,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
