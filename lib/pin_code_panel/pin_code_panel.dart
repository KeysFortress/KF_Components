import 'package:components/custom_button/custom_button.dart';
import 'package:components/custom_text_field/custom_text_field.dart';
import 'package:components/horizontal_divider/horizontal_divider.dart';
import 'package:components/keyboard_button/keyboard_button.dart';
import 'package:components/pin_code_panel/pin_code_panel_viewmodel.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PinCodePanel extends StatelessWidget {
  const PinCodePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PinCodePanelViewModel(context),
      builder: (context, viewModel, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                  "Enter your 6 digit pin",
                  style: ThemeStyles.regularParagraph,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  floatingLabel: "Pin",
                  onChange: () {},
                  enabled: false,
                  isObscured: viewModel.isPasswordHidden,
                  controller: TextEditingController(
                    text: viewModel.password,
                  ),
                ),
                const HorizontalDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: KeyboardButton(
                        number: 1,
                        onPressed: (int number) =>
                            viewModel.buttonPressed(number),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: KeyboardButton(
                        number: 2,
                        onPressed: (int number) =>
                            viewModel.buttonPressed(number),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: KeyboardButton(
                        number: 3,
                        onPressed: (int number) =>
                            viewModel.buttonPressed(number),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: KeyboardButton(
                        number: 4,
                        onPressed: (int number) =>
                            viewModel.buttonPressed(number),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: KeyboardButton(
                        number: 5,
                        onPressed: (int number) =>
                            viewModel.buttonPressed(number),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: KeyboardButton(
                        number: 6,
                        onPressed: (int number) =>
                            viewModel.buttonPressed(number),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: KeyboardButton(
                        number: 7,
                        onPressed: (int number) =>
                            viewModel.buttonPressed(number),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: KeyboardButton(
                        number: 8,
                        onPressed: (int number) =>
                            viewModel.buttonPressed(number),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: KeyboardButton(
                        number: 9,
                        onPressed: (int number) =>
                            viewModel.buttonPressed(number),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        callback: viewModel.onChangeVisability,
                        widget: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: ThemeStyles.theme.primary300,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            viewModel.isPasswordHidden
                                ? Icons.remove_red_eye_outlined
                                : Icons.remove_red_eye,
                            color: ThemeStyles.theme.text300,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: KeyboardButton(
                        number: 0,
                        onPressed: (int number) =>
                            viewModel.buttonPressed(number),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomButton(
                        callback: viewModel.onRemovePressed,
                        widget: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: ThemeStyles.theme.primary300,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.backspace_rounded,
                            color: ThemeStyles.theme.text300,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
