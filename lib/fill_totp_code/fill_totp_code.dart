import 'package:components/custom_text_field/custom_text_field.dart';
import 'package:components/fill_totp_code/fill_totp_code_viewmodel.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class FillTotpCode extends StatelessWidget {
  const FillTotpCode({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => FillTotpCodeViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => viewModel.isLocked
          ? SizedBox(
              width: ThemeStyles.width,
              height: ThemeStyles.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                    decoration: BoxDecoration(
                      color: ThemeStyles.theme.background200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: SvgPicture.asset(
                      "assets/images/timer.svg",
                      package: "domain",
                      width: 40,
                      height: 90,
                    ),
                  ),
                  Container(
                    height: 130,
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                    decoration: BoxDecoration(
                      color: ThemeStyles.theme.background200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Enter your TOTP code",
                          style: ThemeStyles.regularParagraphOv(
                            color: ThemeStyles.theme.primary300,
                            size: 18,
                            weight: FontWeight.bold,
                          ),
                        ),
                        CustomTextField(
                          floatingLabel: "Totp Code",
                          onChange: viewModel.onCodeChanged,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Column(),
    );
  }
}
