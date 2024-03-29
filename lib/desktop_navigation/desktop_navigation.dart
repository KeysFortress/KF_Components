import 'package:components/dashboard_toggle/dasboard_toggle.dart';
import 'package:components/desktop_navigation/desktop_navigation_viewmodel.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:shared/base_component_toggle.dart';

class DesktopNavigation extends StatelessWidget {
  final BuildContext context;
  const DesktopNavigation({super.key, required this.context});

  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext componentContext) {
    return Material(
      child: ViewModelBuilder.reactive(
        viewModelBuilder: () => DesktopNavigationViewModel(context),
        builder: (context, viewModel, child) => Stack(
          children: [
            Container(
              color: ThemeStyles.theme.background100,
              padding: EdgeInsets.fromLTRB(0.1 * ThemeStyles.width!, 0, 0, 0),
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
                              width: 180,
                              viewModel: BaseComponentToggle(
                                context,
                                "assets/images/settings.svg",
                                "Settings",
                                viewModel.onPasswordsPressed,
                              ),
                            ),
                            const SizedBox(width: 16),
                            DashboardToggle(
                              width: 180,
                              viewModel: BaseComponentToggle(
                                context,
                                "assets/images/sync.svg",
                                "Connect",
                                viewModel.onSecretsPressed,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            DashboardToggle(
                              width: 180,
                              viewModel: BaseComponentToggle(
                                context,
                                "assets/images/website-password.svg",
                                "Passwords",
                                viewModel.onPasswordsPressed,
                              ),
                            ),
                            const SizedBox(width: 16),
                            DashboardToggle(
                              width: 180,
                              viewModel: BaseComponentToggle(
                                context,
                                "assets/images/secrets.svg",
                                "Secrets",
                                viewModel.onSecretsPressed,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            DashboardToggle(
                              width: 180,
                              viewModel: BaseComponentToggle(
                                context,
                                "assets/images/timer.svg",
                                "TOTP",
                                viewModel.onTotpPressed,
                              ),
                            ),
                            const SizedBox(width: 16),
                            DashboardToggle(
                              width: 180,
                              viewModel: BaseComponentToggle(
                                context,
                                "assets/images/certificate.svg",
                                "FIDO2",
                                viewModel.onFidoPressed,
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
          ],
        ),
      ),
    );
  }
}
