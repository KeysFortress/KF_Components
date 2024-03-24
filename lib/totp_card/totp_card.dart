import 'package:components/custom_button/custom_button.dart';
import 'package:components/horizontal_divider/horizontal_divider.dart';
import 'package:components/seconds_counter/seconds_counter.dart';
import 'package:components/totp_card/totp_card_viewmodel.dart';
import 'package:domain/models/otp_code.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class TotpCard extends StatelessWidget {
  final OtpCode otpCode;
  final Function? onDelete;
  final bool canDelete;
  final bool checkboxEnabled;
  final bool isChecked;

  const TotpCard({
    super.key,
    required this.otpCode,
    this.canDelete = true,
    this.checkboxEnabled = false,
    this.isChecked = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TotpCardViewModel(context, otpCode),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        decoration: BoxDecoration(
          color: ThemeStyles.theme.background200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  viewModel.code,
                  style: ThemeStyles.regularHeading,
                ),
                const HorizontalDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      viewModel.address,
                      style: ThemeStyles.regularParagraphOv(
                        size: 12,
                        color: ThemeStyles.theme.primary300,
                      ),
                    ),
                    Text(
                      viewModel.issuer,
                      style: ThemeStyles.regularParagraphOv(
                        size: 12,
                        color: ThemeStyles.theme.primary300,
                      ),
                    )
                  ],
                )
              ],
            ),
            Positioned(
              left: 10,
              child: SecoondsCounter(
                otpCode: otpCode,
              ),
            ),
            if (canDelete)
              Positioned(
                right: 10,
                child: CustomButton(
                  widget: SvgPicture.asset(
                    'assets/images/bin.svg',
                    package: 'domain',
                  ),
                  callback: onDelete ?? () {},
                ),
              ),
            if (checkboxEnabled)
              Positioned(
                right: 10,
                child: Checkbox(
                  activeColor: ThemeStyles.theme.primary300,
                  value: isChecked,
                  onChanged: (value) => () {},
                ),
              )
          ],
        ),
      ),
    );
  }
}
