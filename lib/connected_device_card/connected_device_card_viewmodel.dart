import 'package:domain/models/device.dart';
import 'package:domain/models/enums.dart';
import 'package:infrastructure/interfaces/idevices_service.dart';
import 'package:infrastructure/interfaces/isync_service.dart';
import 'package:shared/component_base_model.dart';

class ConnectedDeviceCardViewModel extends ComponentBaseModel {
  late IDevicesService _devicesService;
  late ISyncService _syncService;

  late Device _device;
  Device get device => _device;
  bool _isOnline = false;
  bool get isOnline => _isOnline;
  SyncTypes _activeType = SyncTypes.otc;
  SyncTypes get activeType => _activeType;

  ConnectedDeviceCardViewModel(super.context, Device currentDevice) {
    _device = currentDevice;
    _devicesService = getIt.get<IDevicesService>();
    _syncService = getIt.get<ISyncService>();
  }

  ready() async {
    _isOnline = await _devicesService.isDeviceConnected(_device);
    _activeType = await _syncService.getSyncType(_device.mac);
    notifyListeners();
  }
}
