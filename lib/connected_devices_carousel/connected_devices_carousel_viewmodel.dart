import 'package:components/connected_device_card/connected_device_card.dart';
import 'package:components/connected_device_card/connection_card.dart';
import 'package:domain/models/device.dart';
import 'package:domain/models/enums.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/interfaces/idevices_service.dart';
import 'package:shared/component_base_model.dart';

class ConnectedDevicesCarouselViewModel extends ComponentBaseModel {
  late IDevicesService _devicesService;
  ConnectedDevicesCarouselViewModel(super.context) {
    _devicesService = getIt.get<IDevicesService>();
  }

  List<Widget> _cards = [];
  List<Widget> get cards => _cards;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  ScrollController _scrollController = ScrollController();
  ScrollController get mainScollHandler => _scrollController;

  ready() async {
    List<Device> connectedDevices = [];
    var devices = await _devicesService.all();
    for (var device in devices) {
      var connected = await _devicesService.isDeviceConnected(device);
      if (connected) connectedDevices.add(device);
    }

    notifyListeners();
  }

  onScroll(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      // Handle scroll end event here
    }
    _selectedIndex =
        (_scrollController.position.pixels / ThemeStyles.width!).round();
    notifyListeners();
    return false;
  }
}
