import 'package:domain/models/device.dart';
import 'package:infrastructure/interfaces/idevices_service.dart';
import 'package:shared/component_base_model.dart';

class ConnectedDeviceCardViewModel extends ComponentBaseModel {
  late IDevicesService _devicesService;

  late Device _device;
  Device get device => _device;
  bool _isOnline = false;
  bool get isOnline => _isOnline;

  ConnectedDeviceCardViewModel(super.context, Device currentDevice) {
    _device = currentDevice;
    _devicesService = getIt.get<IDevicesService>();
  }

  ready() async {
    _isOnline = await _devicesService.isDeviceConnected(_device);
    notifyListeners();
  }
}
