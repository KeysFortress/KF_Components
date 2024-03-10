import 'package:components/custom_button/custom_button.dart';
import 'package:components/password_strenght/password_strenght.dart';
import 'package:components/secret_card/secret_card.viewmodel.dart';
import 'package:domain/models/stored_secret.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class SecretCard extends StatelessWidget {
  final StoredSecret secret;
  final bool copyEnabled;
  final bool checkboxEnabled;
  final bool isChecked;
  final Function? onActionCallback;

  const SecretCard({
    super.key,
    required this.secret,
    this.copyEnabled = true,
    this.checkboxEnabled = false,
    this.isChecked = false,
    this.onActionCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => SecretCardViewModel(context, secret),
      builder: (context, viewModel, child) => Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        decoration: BoxDecoration(
          color: ThemeStyles.theme.background200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Builder(
          builder: (context) {
            var pageData = Stack(
              children: [
                if (copyEnabled)
                  Positioned(
                    right: 0,
                    child: CustomButton(
                      widget: SvgPicture.asset(
                        "assets/images/copy.svg",
                        package: 'domain',
                        width: 20,
                        height: 20,
                      ),
                      callback: () {},
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/website-password.svg',
                          package: 'domain',
                          width: 40,
                          height: 40,
                          colorFilter: ColorFilter.mode(
                            ThemeStyles.theme.primary300,
                            BlendMode.srcIn,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            secret.name,
                            style: ThemeStyles.regularParagraphOv(
                              size: 16,
                              color: ThemeStyles.theme.primary300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PasswordStrenght(
                        initial: secret.content,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          secret.username,
                          style: ThemeStyles.regularParagraphOv(
                            size: 12,
                            color: ThemeStyles.theme.primary300,
                          ),
                        ),
                        Text(
                          "Last used: ${secret.lastUsed.day}/${secret.lastUsed.month}/${secret.lastUsed.year}",
                          style: ThemeStyles.regularParagraphOv(
                            size: 12,
                            color: ThemeStyles.theme.primary300,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            );

            if (copyEnabled) {
              return CustomButton(
                callback: copyEnabled
                    ? viewModel.onCopyPressed
                    : () => onActionCallback?.call(),
                widget: pageData,
              );
            }

            return pageData;
          },
        ),
      ),
    );
  }
}
