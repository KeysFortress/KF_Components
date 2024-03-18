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
          if (viewModel.cards.isEmpty) const MissingConnections(),
          if (viewModel.cards.isNotEmpty)
            Column(
              children: [
                SizedBox(
                  height: 160,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) =>
                        viewModel.onScroll(notification),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const RangeMaintainingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: viewModel.mainScollHandler,
                      itemCount: viewModel.cards.length,
                      itemBuilder: (context, index) => Container(
                          width: ThemeStyles.width! * 0.9,
                          margin: const EdgeInsets.only(right: 16),
                          child: viewModel.cards.elementAtOrNull(index)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 2,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: viewModel.cards.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: viewModel.cards.length > 9
                          ? (ThemeStyles.width! - 160) / viewModel.cards.length
                          : 32,
                      color: viewModel.selectedIndex == index
                          ? ThemeStyles.theme.primary300
                          : ThemeStyles.theme.accent100,
                    ),
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}
