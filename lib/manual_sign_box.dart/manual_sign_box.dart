import 'package:domain/converters/binary_converter.dart';
import 'package:domain/models/stored_identity.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../custom_button/custom_button.dart';
import '../custom_icon_button/custom_icon_button.dart';
import '../custom_text_field/custom_text_field.dart';
import '../secret_container/secret_container.dart';
import 'manual_sign_box.viewmodel.dart';

class ManualSignBox extends StatelessWidget {
  final Function onSave;
  final StoredIdentity identity;
  const ManualSignBox({
    super.key,
    required this.identity,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ManualSignBoxViewModel(context, identity, onSave),
      builder: (context, viewModel, child) => Container(
        color: ThemeStyles.theme.background200,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Visibility(
            visible: viewModel.signature == null,
            replacement: Column(
              children: [
                Text(
                  "Input",
                  style: ThemeStyles.regularHeading,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(6),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.primary300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    viewModel.message,
                    style: ThemeStyles.regularParagraphOv(
                      size: 16,
                      color: ThemeStyles.theme.text300,
                      weight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Produced hex",
                  style: ThemeStyles.regularHeading,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.primary300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    BianaryConverter.toHex(viewModel.message.codeUnits),
                    style: ThemeStyles.regularParagraphOv(
                      size: 16,
                      color: ThemeStyles.theme.text300,
                      weight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Generated Signature",
                  style: ThemeStyles.regularHeading,
                ),
                const SizedBox(height: 8),
                if (viewModel.signature != null)
                  SecretContainer(
                    display: identity.publicKey,
                    icon: Icons.fingerprint,
                    value: BianaryConverter.toHex(viewModel.signature!.bytes),
                  ),
                const SizedBox(height: 8),
                SecretContainer(
                  display: identity.publicKey,
                  icon: Icons.public,
                  value: identity.publicKey,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  floatingLabel: "url",
                  onChange: viewModel.onUrlChanged,
                  height: 50,
                  innerButon: Icon(
                    Icons.wb_cloudy_outlined,
                    color: ThemeStyles.theme.accent100,
                  ),
                ),
                if (!viewModel.advanced)
                  CustomButton(
                    widget: Text(
                      "advanced",
                      style: ThemeStyles.regularParagraphOv(
                        size: 13,
                        color: ThemeStyles.theme.primary300,
                        decoration: TextDecoration.underline,
                        weight: FontWeight.bold,
                      ),
                    ),
                    callback: viewModel.onAdvancedPressed,
                  ),
                if (viewModel.advanced)
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: CustomTextField(
                      floatingLabel: "Bearer",
                      onChange: viewModel.onBearerChanged,
                      height: 50,
                      innerButon: Icon(
                        Icons.lock,
                        color: ThemeStyles.theme.accent100,
                      ),
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CustomIconButton(
                      expand: true,
                      label: "Close",
                      callback: viewModel.onClose,
                      buttonColor: ThemeStyles.theme.primary300,
                      height: 50,
                    ),
                    const SizedBox(width: 8),
                    CustomIconButton(
                      expand: true,
                      label: "Send",
                      callback: viewModel.onSend,
                      height: 50,
                    ),
                  ],
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(32, 0, 32, 16),
                  width: double.infinity,
                  height: 5,
                  decoration: BoxDecoration(
                    color: ThemeStyles.theme.accent200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                CustomTextField(
                  floatingLabel: "Challenge",
                  hint: "base64 message",
                  onChange: viewModel.onMessageChanged,
                  height: 50,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  floatingLabel: "Data",
                  onChange: viewModel.onDataChanged,
                  height: 50,
                ),
                const SizedBox(height: 8),
                CustomIconButton(
                  label: "Sign",
                  callback: viewModel.onSave,
                  height: 50,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
