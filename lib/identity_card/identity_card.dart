import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../custom_button/custom_button.dart';
import 'identity_card.viewmodel.dart';

class IdentityCard extends StatelessWidget {
  final StoredIdentity identity;
  final bool isHistoryEnabled;
  final bool isSignatureEnabled;
  final bool isScanEnabled;
  final bool checkboxEnabled;
  final bool isChecked;
  const IdentityCard({
    super.key,
    required this.identity,
    this.isHistoryEnabled = true,
    this.isSignatureEnabled = true,
    this.isScanEnabled = true,
    this.checkboxEnabled = false,
    this.isChecked = false,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => IdentityCardViewModel(context, identity),
      builder: (context, viewModel, child) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        decoration: BoxDecoration(
          color: ThemeStyles.theme.background200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: [
            if (isHistoryEnabled)
              Positioned(
                left: 0,
                child: CustomButton(
                  widget: SvgPicture.asset(
                    "assets/images/history.svg",
                    package: 'domain',
                    width: 20,
                    height: 20,
                  ),
                  callback: viewModel.viewHistory,
                ),
              ),
            if (isScanEnabled)
              Positioned(
                right: 0,
                child: CustomButton(
                  widget: SvgPicture.asset(
                    "assets/images/scan.svg",
                    package: 'domain',
                    width: 20,
                    height: 20,
                  ),
                  callback: viewModel.onConnectPressed,
                ),
              ),
            if (checkboxEnabled)
              Positioned(
                right: 0,
                child: Checkbox(
                  activeColor: ThemeStyles.theme.primary300,
                  value: isChecked,
                  onChanged: (value) => () {},
                ),
              ),
            Column(
              children: [
                SvgPicture.asset(
                  'assets/images/certificate.svg',
                  package: 'domain',
                  width: 90,
                  height: 90,
                  colorFilter: ColorFilter.mode(
                    ThemeStyles.theme.primary300,
                    BlendMode.srcIn,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        identity.name,
                        style: ThemeStyles.regularParagraphOv(
                          size: 16,
                          color: ThemeStyles.theme.primary300,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.primary300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Icon(
                        Icons.public,
                        color: ThemeStyles.theme.text300,
                        size: 35,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Column(
                          children: [
                            Text(
                              identity.publicKey,
                              style: ThemeStyles.regularParagraphOv(
                                size: 14,
                                color: ThemeStyles.theme.text300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.copy,
                        color: ThemeStyles.theme.text300,
                        size: 35,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.primary300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 8),
                      Icon(
                        Icons.privacy_tip_outlined,
                        color: ThemeStyles.theme.text300,
                        size: 35,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "*********************************",
                              style: ThemeStyles.regularParagraphOv(
                                size: 14,
                                color: ThemeStyles.theme.text300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.copy,
                        color: ThemeStyles.theme.text300,
                        size: 35,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                if (isSignatureEnabled)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                        height: 50,
                        expand: true,
                        label: "Sign",
                        callback: viewModel.onManualSignPressed,
                      )
                    ],
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
