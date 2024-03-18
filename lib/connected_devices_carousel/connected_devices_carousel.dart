import 'package:components/connected_devices_carousel/connected_devices_carousel_viewmodel.dart';
import 'package:components/missing_connections/missing_connections.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ConnectedDevicesCarousel extends StatelessWidget {
  const ConnectedDevicesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => ConnectedDevicesCarouselViewModel(context),
      onViewModelReady: (viewModel) => viewModel.ready(),
      builder: (context, viewModel, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (viewModel.cards.isEmpty)
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(
                color: ThemeStyles.theme.background200,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const MissingConnections(),
            ),
          if (viewModel.cards.isNotEmpty)
            Column(
              children: [
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const PageScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: viewModel.mainScollHandler,
                    itemCount: viewModel.cards.length,
                    itemBuilder: (context, index) => SizedBox(
                      width: ThemeStyles.width,
                      child: viewModel.cards.elementAtOrNull(index),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
