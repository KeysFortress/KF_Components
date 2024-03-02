import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:components/custom_slider/custom_slider.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../custom_text_field/custom_text_field.dart';
import '../password_strenght/password_strenght.dart';
import 'password_entry_box.viewmodel.dart';

class PasswordEntryBox extends StatelessWidget {
  final String password;
  final Function onSave;
  const PasswordEntryBox({
    super.key,
    required this.password,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PasswordEntryBoxViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(password),
      builder: (context, viewModel, child) => Container(
        color: ThemeStyles.theme.background200,
        child: Container(
          margin: const EdgeInsets.all(20),
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
                floatingLabel: "Name",
                onChange: viewModel.onNameChanged,
                height: 50,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                floatingLabel: "Email",
                onChange: viewModel.onEmailChanged,
                height: 50,
              ),
              const SizedBox(height: 8),
              Text(
                viewModel.password,
                style: ThemeStyles.regularParagraphOv(
                  size: 18,
                  color: ThemeStyles.theme.primary300,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 8),
              PasswordStrenght(
                initial: viewModel.password,
              ),
              const SizedBox(
                height: 16,
              ),
              if (viewModel.isAdvanced)
                Column(
                  children: [
                    Text(
                      "Password lenght: ${viewModel.passwordSize.toInt().toString()}",
                      style: ThemeStyles.regularParagraphOv(
                        color: ThemeStyles.theme.primary300,
                      ),
                    ),
                    CustomSlider(
                      initialValue: viewModel.passwordSize,
                      minValue: 12,
                      maxValue: 512,
                      divisios: 512,
                      slidingStopped: (value) => viewModel.applyLenght(value),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Allow Special (@,!,|)",
                          style: ThemeStyles.regularParagraphOv(
                            color: ThemeStyles.theme.primary300,
                            size: 18,
                          ),
                        ),
                        Switch(
                          value: viewModel.isSpecialAllowed,
                          onChanged: viewModel.onAllowSpecialChaged,
                          activeColor: ThemeStyles.theme.primary300,
                          activeTrackColor: ThemeStyles.theme.primary200,
                          inactiveTrackColor: ThemeStyles.theme.primary300,
                          inactiveThumbColor: ThemeStyles.theme.primary200,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rquire Upper Chracters",
                          style: ThemeStyles.regularParagraphOv(
                              color: ThemeStyles.theme.primary300, size: 18),
                        ),
                        Switch(
                          value: viewModel.isUpper,
                          onChanged: viewModel.onIsUpperChanged,
                          activeColor: ThemeStyles.theme.primary300,
                          activeTrackColor: ThemeStyles.theme.primary200,
                          inactiveTrackColor: ThemeStyles.theme.primary300,
                          inactiveThumbColor: ThemeStyles.theme.primary200,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Require Digits",
                          style: ThemeStyles.regularParagraphOv(
                              color: ThemeStyles.theme.primary300, size: 18),
                        ),
                        Switch(
                          value: viewModel.isDigit,
                          onChanged: viewModel.onIsDigitChanged,
                          activeColor: ThemeStyles.theme.primary300,
                          activeTrackColor: ThemeStyles.theme.primary200,
                          inactiveTrackColor: ThemeStyles.theme.primary300,
                          inactiveThumbColor: ThemeStyles.theme.primary200,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rquire Lower Characters",
                          style: ThemeStyles.regularParagraphOv(
                              color: ThemeStyles.theme.primary300, size: 18),
                        ),
                        Switch(
                          value: viewModel.isLower,
                          onChanged: viewModel.onAllowLowerChanged,
                          activeColor: ThemeStyles.theme.primary300,
                          activeTrackColor: ThemeStyles.theme.primary200,
                          inactiveTrackColor: ThemeStyles.theme.primary300,
                          inactiveThumbColor: ThemeStyles.theme.primary200,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ensure Unique password",
                          style: ThemeStyles.regularParagraphOv(
                            color: ThemeStyles.theme.primary300,
                            size: 18,
                          ),
                        ),
                        Switch(
                          value: viewModel.isUnique,
                          onChanged: viewModel.onIsUniqueChanged,
                          activeColor: ThemeStyles.theme.primary300,
                          activeTrackColor: ThemeStyles.theme.primary200,
                          inactiveTrackColor: ThemeStyles.theme.primary300,
                          inactiveThumbColor: ThemeStyles.theme.primary200,
                        ),
                      ],
                    )
                  ],
                ),
              CustomButton(
                callback: viewModel.onAdvancedPressed,
                widget: Text(
                  viewModel.isAdvanced ? "Hide" : "Advanced",
                  style: ThemeStyles.regularParagraphOv(
                    decoration: TextDecoration.underline,
                    size: 16,
                    color: ThemeStyles.theme.primary300,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              CustomIconButton(
                label: "Save",
                height: 50,
                callback: () async {
                  await viewModel.onSave();
                  onSave.call();
                },
              ),
              const SizedBox(height: 8),
              Text(
                "Passwords are automatically copied after saving",
                style: ThemeStyles.regularParagraph,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
