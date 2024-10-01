import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:montra_clone/modules/bottom_navigation_bar/remote_config_service.dart';

part 'configuration_state.dart';

class ConfigurationCubit extends Cubit<ConfigurationState> {
  ConfigurationCubit() : super(const ConfigurationState()) {
    getRemoteConfigValue();
  }

  Future<void> getRemoteConfigValue() async {
    try {
      emit(state.copyWith(status: ApiStatus.loading));
      final isFabCentreDocked =
          RemoteConfigService.instance.shouldShowFabInCentre();
      emit(state.copyWith(
        shouldShowFabInCentre: isFabCentreDocked,
        status: ApiStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: ApiStatus.failure));
    }
  }
}