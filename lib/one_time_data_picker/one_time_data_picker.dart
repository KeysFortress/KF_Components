import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/identity_card/identity_card.dart';
import 'package:components/one_time_data_picker/one_time_data_picker_viewmodel.dart';
import 'package:components/secret_card/secret_card.dart';
import 'package:components/totp_card/totp_card.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class OneTimeDataPicker extends StatelessWidget {
  final Function onSelected;
  const OneTimeDataPicker({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => OneTimeDataPickerViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) {
        return Container(
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
                height: ThemeStyles.height! - 200,
                child: ListView.builder(
                  itemCount: viewModel.getItemCount(),
                  itemBuilder: (context, index) {
                    switch (viewModel.selected) {
                      case ActiveNavigationPage.passwords:
                        return CustomButton(
                          callback: () => onSelected.call(
                            {
                              'type': 1,
                              'data': viewModel.secrets.elementAt(index)
                            },
                          ),
                          widget: SecretCard(
                            secret: viewModel.secrets.elementAt(index),
                            checkboxEnabled: false,
                            isChecked: false,
                            copyEnabled: false,
                          ),
                        );
                      case ActiveNavigationPage.totp:
                        return CustomButton(
                          callback: () => onSelected.call(
                            {
                              'type': 2,
                              'data': viewModel.codes.elementAt(index)
                            },
                          ),
                          widget: TotpCard(
                            otpCode: viewModel.codes.elementAt(index),
                            canDelete: false,
                            checkboxEnabled: false,
                          ),
                        );
                      case ActiveNavigationPage.secrets:
                      case ActiveNavigationPage.syncMode:
                        break;
                      case ActiveNavigationPage.identities:
                        return CustomButton(
                          callback: () => onSelected.call(
                            {
                              'type': 3,
                              'data': viewModel.identities.elementAt(index)
                            },
                          ),
                          widget: IdentityCard(
                            identity: viewModel.identities.elementAt(index),
                            isSignatureEnabled: false,
                            isScanEnabled: false,
                            isHistoryEnabled: false,
                            checkboxEnabled: false,
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
                    playAnim:
                        viewModel.selected == ActiveNavigationPage.passwords
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
                    callback:
                        viewModel.selected == ActiveNavigationPage.passwords
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
            ],
          ),
        );
      },
    );
  }
}
