import 'package:components/custom_button/custom_button.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';

class KeyboardButton extends StatelessWidget {
  final Function onPressed;
  final int number;
  const KeyboardButton(
      {super.key, required this.onPressed, required this.number});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      callback: () => onPressed.call(number),
      widget: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: ThemeStyles.theme.primary300,
            borderRadius: BorderRadius.circular(8)),
        child: Text(
          "$number",
          style: ThemeStyles.regularParagraphOv(
            size: 18,
            color: ThemeStyles.theme.text300,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
