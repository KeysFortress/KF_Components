import 'package:components/keyboard_menu/keyboard_menu_viewmodel.dart';
import 'package:components/simple_toggle/simple_toggle.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class KeyboardMenu extends StatelessWidget {
  const KeyboardMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => KeybaordMenuViewModel(context),
      builder: (context, viewModel, child) => Container(
        color: ThemeStyles.theme.background300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              decoration: BoxDecoration(
                color: ThemeStyles.theme.background200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SimpleToggle(
                          height: 120,
                          width: double.infinity,
                          icon: "assets/images/website-password.svg",
                          title: "Passwords",
                          isActive: false,
                          onPressed: viewModel.onPasswordsPressed,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SimpleToggle(
                          height: 120,
                          width: double.infinity,
                          icon: "assets/images/secrets_fill.svg",
                          title: "Secrets",
                          isActive: false,
                          onPressed: () {},
                          color: ThemeStyles.theme.primary300.withAlpha(150),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SimpleToggle(
                          height: 120,
                          width: double.infinity,
                          icon: "assets/images/timer.svg",
                          title: "TOTP/OTP",
                          isActive: false,
                          onPressed: viewModel.onTotpPressed,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: SimpleToggle(
                          height: 120,
                          width: double.infinity,
                          icon: "assets/images/rac.svg",
                          title: "RAC",
                          isActive: false,
                          onPressed: () {},
                          color: ThemeStyles.theme.primary300.withAlpha(150),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SimpleToggle(
                          height: 120,
                          width: double.infinity,
                          icon: "assets/images/rlc.svg",
                          title: "RLC",
                          isActive: false,
                          onPressed: () {},
                          color: ThemeStyles.theme.primary300.withAlpha(150),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SimpleToggle(
                          height: 120,
                          width: double.infinity,
                          icon: "assets/images/certificate.svg",
                          title: "Identities",
                          isActive: false,
                          onPressed: viewModel.onIdentitiesPressed,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
