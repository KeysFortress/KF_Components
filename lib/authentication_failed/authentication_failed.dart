import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthenticationFailed extends StatelessWidget {
  final Function onTryAgain;
  const AuthenticationFailed({super.key, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Remaining attempts before locking",
          style: ThemeStyles.regularParagraph,
        ),
        SvgPicture.asset(
          "assets/images/exclamation-triangle.svg",
          package: 'domain',
          width: ThemeStyles.width! / 4,
          colorFilter: ColorFilter.mode(
            ThemeStyles.theme.primary300,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Oops, something went wrong, please try again...",
          style: ThemeStyles.regularHeading,
        ),
        const SizedBox(
          height: 16,
        ),
        CustomIconButton(label: "Try again", callback: onTryAgain),
      ],
    );
  }
}
