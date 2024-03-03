import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../custom_icon_button/custom_icon_button.dart';
import 'navigation_menu.viewmodel.dart';

class NavigationMenu extends StatelessWidget {
  final ActiveNavigationPage currentPage;
  const NavigationMenu({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NavigationMenuViewModel(context, currentPage),
      builder: (context, viewModel, child) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomIconButton(
              buttonColor: ThemeStyles.theme.primary300,
              btnRadius: 0,
              expand: true,
              playAnim: viewModel.selected == ActiveNavigationPage.passwords
                  ? false
                  : true,
              icon: SvgPicture.asset(
                "assets/images/website-password.svg",
                package: 'domain',
                width: 50,
                colorFilter: ColorFilter.mode(
                  viewModel.selected == ActiveNavigationPage.passwords
                      ? ThemeStyles.theme.accent100
                      : ThemeStyles.theme.accent200,
                  BlendMode.srcIn,
                ),
              ),
              label: "",
              callback: viewModel.selected == ActiveNavigationPage.passwords
                  ? () {}
                  : viewModel.onPasswordsPressed,
            ),
            CustomIconButton(
              buttonColor: ThemeStyles.theme.primary300,
              btnRadius: 0,
              expand: true,
              playAnim: viewModel.selected == ActiveNavigationPage.totp
                  ? false
                  : true,
              icon: SvgPicture.asset(
                "assets/images/timer.svg",
                package: 'domain',
                colorFilter: ColorFilter.mode(
                  viewModel.selected == ActiveNavigationPage.totp
                      ? ThemeStyles.theme.accent100
                      : ThemeStyles.theme.accent200,
                  BlendMode.srcIn,
                ),
                width: 50,
              ),
              label: "",
              callback: viewModel.selected == ActiveNavigationPage.totp
                  ? () {}
                  : viewModel.onTotpPressed,
            ),
            CustomIconButton(
              playAnim: viewModel.selected == ActiveNavigationPage.identities
                  ? false
                  : true,
              buttonColor: ThemeStyles.theme.primary300,
              btnRadius: 0,
              expand: true,
              icon: SvgPicture.asset(
                "assets/images/certificate.svg",
                package: 'domain',
                colorFilter: ColorFilter.mode(
                  viewModel.selected == ActiveNavigationPage.identities
                      ? ThemeStyles.theme.accent100
                      : ThemeStyles.theme.accent200,
                  BlendMode.srcIn,
                ),
                width: 50,
              ),
              label: "",
              callback: viewModel.selected == ActiveNavigationPage.identities
                  ? () {}
                  : viewModel.onCertificatesPressed,
            )
          ],
        ),
      ),
    );
  }
}
