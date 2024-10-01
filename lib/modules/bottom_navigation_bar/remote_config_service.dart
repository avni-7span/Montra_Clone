import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final RemoteConfigService instance = RemoteConfigService._internal();
  factory RemoteConfigService() => instance;
  RemoteConfigService._internal()
      : _remoteConfigService = FirebaseRemoteConfig.instance;

  final FirebaseRemoteConfig _remoteConfigService;

  Future<void> initialize() async {
    await _remoteConfigService.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 0),
      minimumFetchInterval: const Duration(hours: 0),
    ));
    await _remoteConfigService.fetchAndActivate();
  }

  bool shouldShowFabInCentre() {
    final isFabInCentre =
        _remoteConfigService.getString('should_show_fab_in_centre');
    if (isFabInCentre == 'true') {
      return true;
    } else {
      return false;
    }
  }
}
