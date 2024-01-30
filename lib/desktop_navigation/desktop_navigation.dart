import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/dashboard_toggle/dasboard_toggle.dart';
import 'package:components/desktop_navigation/desktop_navigation_viewmodel.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:shared/base_component_toggle.dart';

class DesktopNavigation extends StatelessWidget {
  const DesktopNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DesktopNavigationViewModel(context),
      builder: (context, viewModel, child) => Container(
        color: ThemeStyles.theme.background100,
        padding: EdgeInsets.fromLTRB(
            0.2 * MediaQuery.of(context).size.width, 0, 0, 0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Row(
                    children: [
                      DashboardToggle(
                        viewModel: BaseComponentToggle(
                          context,
                          "assets/images/website-password.svg",
                          "Passwords",
                        ),
                      ),
                      const SizedBox(width: 8),
                      DashboardToggle(
                        viewModel: BaseComponentToggle(
                          context,
                          "assets/images/secrets.svg",
                          "Secrets",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      DashboardToggle(
                        viewModel: BaseComponentToggle(
                          context,
                          "assets/images/website-password.svg",
                          "TOTP",
                        ),
                      ),
                      const SizedBox(width: 8),
                      DashboardToggle(
                        viewModel: BaseComponentToggle(
                          context,
                          "assets/images/timer.svg",
                          "FIDO2",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
