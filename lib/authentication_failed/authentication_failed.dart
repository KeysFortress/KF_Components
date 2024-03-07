import 'package:components/custom_icon_button/custom_icon_button.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthenticationFailed extends StatelessWidget {
  final Function onTryAgain;
  const AuthenticationFailed({super.key, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Oops, something went wrong, please try again...",
            style: ThemeStyles.regularInnerHeading,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
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
            "Remaining attempts before data descrution",
            style: ThemeStyles.regularParagraph,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomIconButton(
            buttonColor: ThemeStyles.theme.primary300,
            label: "Try again",
            callback: onTryAgain,
            height: 50,
          ),
        ],
      ),
    );
  }
}
