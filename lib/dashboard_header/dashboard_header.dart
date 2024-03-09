import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../custom_icon_button/custom_icon_button.dart';
import 'dashboard_header.viewmodel.dart';

class DashboardHeader extends StatelessWidget {
  final Function onNewPassword;
  final String name;
  final String icon;
  final ActiveNavigationPage type;
  final bool btnVisible;

  const DashboardHeader({
    super.key,
    required this.onNewPassword,
    required this.type,
    required this.name,
    required this.icon,
    this.btnVisible = true,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DashboardHeaderViewModel(context, type),
      builder: (context, viewModel, child) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ThemeStyles.theme.primary300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/images/$icon",
                  package: 'domain',
                  width: 80,
                  colorFilter: ColorFilter.mode(
                    ThemeStyles.theme.accent100,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: ThemeStyles.regularParagraphOv(
                        size: 23,
                        color: ThemeStyles.theme.accent100,
                      ),
                    ),
                    Text(
                      "Last used: ${viewModel.lastUsed}",
                      style: ThemeStyles.regularParagraphOv(
                        size: 19,
                        color: ThemeStyles.theme.accent100,
                      ),
                    )
                  ],
                ),
              ],
            ),
            if (btnVisible)
              Column(
                children: [
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: CustomIconButton(
                      expand: false,
                      height: 40,
                      icon: SvgPicture.asset(
                        'assets/images/engine.svg',
                        package: 'domain',
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          ThemeStyles.theme.primary300,
                          BlendMode.srcIn,
                        ),
                      ),
                      label: "Generate new",
                      callback: () {
                        onNewPassword.call();
                      },
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
