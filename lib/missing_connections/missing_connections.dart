import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MissingConnections extends StatelessWidget {
  const MissingConnections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/computer.svg",
          package: 'domain',
          fit: BoxFit.contain,
          height: 80,
          colorFilter: ColorFilter.mode(
            ThemeStyles.theme.primary300,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Oops. it appears that there are no nearby devices connected, please check if you're connected over wifi network as the device you're trying to reach.",
          style: ThemeStyles.regularParagraphOv(
            size: 12,
            color: ThemeStyles.theme.primary300,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
