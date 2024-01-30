import 'package:components/dashboard_toggle/dasboard_toggle.dart';
import 'package:components/desktop_navigation/desktop_navigation_viewmodel.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:shared/base_component_toggle.dart';

class DesktopNavigation extends StatelessWidget {
  final Function onPageChanged;
  const DesktopNavigation({super.key, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () =>
          DesktopNavigationViewModel(context, onPageChanged),
      builder: (context, viewModel, child) => Stack(
        children: [
          Container(
            color: ThemeStyles.theme.background100,
            padding: EdgeInsets.fromLTRB(
                0.1 * MediaQuery.of(context).size.width, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                                viewModel.onPasswordsPressed),
                          ),
                          const SizedBox(width: 8),
                          DashboardToggle(
                            viewModel: BaseComponentToggle(
                                context,
                                "assets/images/secrets.svg",
                                "Secrets",
                                viewModel.onSecretsPressed),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          DashboardToggle(
                            viewModel: BaseComponentToggle(
                                context,
                                "assets/images/timer.svg",
                                "TOTP",
                                viewModel.onTotpPressed),
                          ),
                          const SizedBox(width: 8),
                          DashboardToggle(
                            viewModel: BaseComponentToggle(
                                context,
                                "assets/images/certificate.svg",
                                "FIDO2",
                                viewModel.onFidoPressed),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/images/settings.svg",
                  package: "domain",
                  width: 30,
                  height: 30,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
