import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/identity_card/identity_card.dart';
import 'package:components/secret_card/secret_card.dart';
import 'package:components/sync_data_picker/sync_data_picker_viewmodel.dart';
import 'package:components/totp_card/totp_card.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class SyncDataPicker extends StatelessWidget {
  final String deviceId;
  final Function onSelected;
  const SyncDataPicker({
    super.key,
    required this.deviceId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () =>
          SyncDataPickerViewModel(context, deviceId, onSelected),
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
            SizedBox(
              height: ThemeStyles.height! - 250,
              child: ListView.builder(
                itemCount: viewModel.getItemCount(),
                itemBuilder: (context, index) {
                  switch (viewModel.selected) {
                    case ActiveNavigationPage.passwords:
                      return CustomButton(
                        callback: () => viewModel.onSecretSelected(index),
                        widget: SecretCard(
                          secret: viewModel.secrets.elementAt(index),
                          copyEnabled: false,
                          checkboxEnabled: true,
                          isChecked: viewModel.exchangeData.secrets.any(
                            (element) =>
                                element.id ==
                                viewModel.secrets.elementAt(index).id,
                          ),
                        ),
                      );
                    case ActiveNavigationPage.totp:
                      return CustomButton(
                        callback: () => viewModel.onCodeSelected(index),
                        widget: TotpCard(
                          otpCode: viewModel.codes.elementAt(index),
                          canDelete: false,
                          checkboxEnabled: true,
                          isChecked: viewModel.exchangeData.otpCodes.any(
                            (element) =>
                                element.id ==
                                viewModel.codes.elementAt(index).id,
                          ),
                        ),
                      );
                    case ActiveNavigationPage.secrets:
                    case ActiveNavigationPage.syncMode:
                      break;
                    case ActiveNavigationPage.identities:
                      return CustomButton(
                        callback: () => viewModel.onIdentitySelected(index),
                        widget: IdentityCard(
                          identity: viewModel.identities.elementAt(index),
                          isSignatureEnabled: false,
                          isScanEnabled: false,
                          isHistoryEnabled: false,
                          checkboxEnabled: true,
                          isChecked: viewModel.exchangeData.identities.any(
                            (element) =>
                                element.id ==
                                viewModel.identities.elementAt(index).id,
                          ),
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
            ),
            CustomIconButton(
              btnRadius: 0,
              height: 50,
              label: "Save",
              callback: viewModel.onSavePressed,
            )
          ],
        ),
      ),
    );
  }
}
