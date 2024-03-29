import 'package:domain/models/key_dto.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../custom_icon_button/custom_icon_button.dart';
import '../custom_text_field/custom_text_field.dart';
import 'identity_entry_box.viewmodel.dart';

class IdentityEntryBox extends StatelessWidget {
  final KeyDto keyData;
  final Function onSave;
  const IdentityEntryBox({
    super.key,
    required this.keyData,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => IdentityEntryBoxViewModel(context, keyData),
      onViewModelReady: (viewModel) => viewModel.ready(),
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
              Text(
                "Set a name for your new online identity",
                style: ThemeStyles.regularParagraph,
              ),
              CustomTextField(
                floatingLabel: "Name",
                onChange: viewModel.onNameChanged,
                height: 50,
              ),
              const SizedBox(height: 8),
              Text(
                "Public keys are safe to be shared with trusted sources.",
                style: ThemeStyles.regularParagraph,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
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
                            keyData.publicKey,
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
              Text(
                "Never share your private key, it's obscured for a reason.",
                style: ThemeStyles.regularParagraph,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: ThemeStyles.theme.primary300,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        mainAxisAlignment: MainAxisAlignment.center,
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
              CustomIconButton(
                height: 50,
                label: "Save",
                callback: () async {
                  await viewModel.onSave();
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
