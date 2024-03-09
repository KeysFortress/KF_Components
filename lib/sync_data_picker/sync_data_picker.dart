import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/sync_data_picker/sync_data_picker_viewmodel.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class SyncDataPicker extends StatelessWidget {
  final Function onSelected;
  const SyncDataPicker({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SyncDataPickerViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Container(
        color: ThemeStyles.theme.background200,
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(32, 0, 32, 16),
              width: double.infinity,
              height: 5,
              decoration: BoxDecoration(
                color: ThemeStyles.theme.accent200,
              ),
            ),
            Container(
              height: ThemeStyles.height! - 200,
              child: ListView.builder(
                itemCount: viewModel.getItemCount(),
                itemBuilder: (context, index) {
                  switch (viewModel.selected) {
                    case ActiveNavigationPage.passwords:
                      return CustomButton(
                        callback: () => viewModel.onSecretSelected(index),
                        widget: Row(
                          children: [
                            Checkbox(
                              activeColor: ThemeStyles.theme.primary300,
                              value: viewModel.exchangeData.secrets.any(
                                  (element) =>
                                      element ==
                                      viewModel.secrets.elementAt(index)),
                              onChanged: (value) => () {},
                            ),
                            Text(
                              viewModel.secrets.elementAt(index).name,
                              style: ThemeStyles.regularParagraph,
                            )
                          ],
                        ),
                      );
                    case ActiveNavigationPage.totp:
                      return CustomButton(
                        callback: () => viewModel.onCodeSelected(index),
                        widget: Row(
                          children: [
                            Checkbox(
                              activeColor: ThemeStyles.theme.primary300,
                              value: viewModel.exchangeData.otpCodes.any(
                                  (element) =>
                                      element ==
                                      viewModel.codes.elementAt(index)),
                              onChanged: (value) => () {},
                            ),
                            Text(
                              viewModel.secrets.elementAt(index).name,
                              style: ThemeStyles.regularParagraph,
                            )
                          ],
                        ),
                      );
                    case ActiveNavigationPage.secrets:
                    // TODO: Handle this case.
                    case ActiveNavigationPage.syncMode:
                    // TODO: Handle this case.
                    case ActiveNavigationPage.identities:
                      return CustomButton(
                        callback: () => viewModel.onIdentitySelected(index),
                        widget: Row(
                          children: [
                            Checkbox(
                              activeColor: ThemeStyles.theme.primary300,
                              value: viewModel.exchangeData.identities.any(
                                  (element) =>
                                      element ==
                                      viewModel.identities.elementAt(index)),
                              onChanged: (value) => () {},
                            ),
                            Text(
                              viewModel.secrets.elementAt(index).name,
                              style: ThemeStyles.regularParagraph,
                            )
                          ],
                        ),
                      );
                  }
                },
              ),
            ),
            Row(
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
                  playAnim:
                      viewModel.selected == ActiveNavigationPage.identities
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
                  callback:
                      viewModel.selected == ActiveNavigationPage.identities
                          ? () {}
                          : viewModel.onCertificatesPressed,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
