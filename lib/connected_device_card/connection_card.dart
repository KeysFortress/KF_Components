import 'package:components/connected_device_card/connected_device_card_viewmodel.dart';
import 'package:domain/models/device.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

class ConnectionCard extends StatelessWidget {
  final Device device;
  const ConnectionCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ConnectedDeviceCardViewModel(context, device),
      builder: (context, viewModel, child) => Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        decoration: BoxDecoration(
          color: ThemeStyles.theme.background200,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/images/computer.svg",
              package: "domain",
              width: 40,
              height: 80,
              colorFilter: ColorFilter.mode(
                ThemeStyles.theme.primary300,
                BlendMode.srcIn,
              ),
            ),
            Text(
              viewModel.device.name,
              style: ThemeStyles.innerHeadingOv(
                color: ThemeStyles.theme.accent200,
                fontSize: 18,
              ),
            ),
            Container(
              width: 90,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: ThemeStyles.theme.primary300,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(4),
                  topLeft: Radius.circular(4),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.connect_without_contact,
                    size: 20,
                    color: ThemeStyles.theme.text300,
                  ),
                  Text(
                    "${viewModel.activeType.name.characters.first.toUpperCase()} Sync",
                    style: ThemeStyles.regularParagraphOv(
                      color: ThemeStyles.theme.text300,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
