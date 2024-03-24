import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/custom_text_field/custom_text_field.dart';
import 'package:components/horizontal_divider/horizontal_divider.dart';
import 'package:components/seconds_counter/seconds_counter.dart';
import 'package:components/topt_entry_box/totp_entry_box_viewmodel.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TotpEntryBox extends StatelessWidget {
  final Function onSave;
  const TotpEntryBox({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => TotpEntryBoxViewModel(context, onSave),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Container(
        color: ThemeStyles.theme.background200,
        child: SizedBox(
          width: 600,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                width: double.infinity,
                height: 5,
                decoration: BoxDecoration(
                  color: ThemeStyles.theme.accent200,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              CustomTextField(
                floatingLabel: "TOTP Link",
                onChange: viewModel.onLinkChanged,
                height: 50,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(15),
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
                          viewModel.getCode(),
                          style: ThemeStyles.regularHeading,
                        ),
                        const HorizontalDivider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              viewModel.code == null
                                  ? "--"
                                  : viewModel.code!.address,
                              style: ThemeStyles.regularParagraphOv(
                                size: 12,
                                color: ThemeStyles.theme.primary300,
                              ),
                            ),
                            Text(
                              viewModel.code == null
                                  ? "--"
                                  : viewModel.code!.issuer,
                              style: ThemeStyles.regularParagraphOv(
                                size: 12,
                                color: ThemeStyles.theme.primary300,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    if (viewModel.code != null)
                      Positioned(
                        left: 10,
                        child: SecoondsCounter(
                          otpCode: viewModel.code!,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              CustomIconButton(
                label: "Save",
                callback: () {
                  viewModel.onSave();
                  onSave.call();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
