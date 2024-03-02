import 'package:components/copy_password_warning_box/copy_password_warning_box_viewmodel.dart';
import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:domain/styles.dart';
import 'package:domain/models/enums.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CopyPasswordWarningBox extends StatelessWidget {
  final Function onSaveCallback;
  final PasswordWarningBoxType entryType;
  final Function? onCancelPressed;
  const CopyPasswordWarningBox({
    super.key,
    required this.onSaveCallback,
    required this.entryType,
    this.onCancelPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CopyPasswordWarningBoxViewModel(
        context,
        onSaveCallback,
        onCancelPressed,
      ),
      builder: (context, viewModel, child) => Column(
        children: [
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Attention!",
                    style: ThemeStyles.regularHeading,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Copying your password to the clipboard can be risky!",
                    style: ThemeStyles.regularParagraph,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Be cautious, as other apps may have access to your clipboard. Ensure a secure environment before copying sensitive information.",
                    style: ThemeStyles.regularParagraph,
                  ),
                ],
              )),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomIconButton(
                  expand: true,
                  height: 50,
                  label: "Cancel",
                  callback: onCancelPressed ?? viewModel.onCancelPressed,
                ),
                const SizedBox(width: 8),
                CustomIconButton(
                  expand: true,
                  height: 50,
                  label: "Confirm",
                  callback: viewModel.onConfirmPressed,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
