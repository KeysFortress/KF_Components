import 'package:components/custom_button/custom_button.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SimpleToggle extends StatelessWidget {
  final double? width;
  final double height;
  final String icon;
  final String title;
  final bool isActive;
  final Function onPressed;
  final Color? color;

  const SimpleToggle({
    super.key,
    required this.height,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onPressed,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      callback: onPressed,
      widget: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color ??
              (isActive
                  ? ThemeStyles.theme.primary100
                  : ThemeStyles.theme.primary300),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              package: "domain",
              width: 32,
              height: 32,
              colorFilter: ColorFilter.mode(
                ThemeStyles.theme.text300,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              title,
              style: ThemeStyles.regularParagraphOv(
                color: ThemeStyles.theme.text300,
                size: 14,
              ),
              textAlign: TextAlign.center,
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: Text(
                  "active",
                  style: ThemeStyles.regularParagraphOv(
                    size: 12,
                    color: ThemeStyles.theme.text300,
                  ),
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
