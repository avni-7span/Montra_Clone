import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SetCurrencyEvent>(_setCurrency);
    on<FetchCurrencyDetails>(_fetchCurrency);
    on<SetLanguageEvent>(_setLanguage);
    on<FetchLanguageDetails>(_fetchLanguage);
  }

  final preferenceInstance = SharedPreferences.getInstance();

  Future<void> _setCurrency(
    SetCurrencyEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(currency: event.currency));
    final instance = await preferenceInstance;
    instance.setString('Currency', state.currency);
  }

  Future<void> _fetchCurrency(
    FetchCurrencyDetails event,
    Emitter<SettingsState> emit,
  ) async {
    final instance = await preferenceInstance;
    final currency = instance.getString('Currency');
    emit(state.copyWith(currency: currency));
  }

  Future<void> _setLanguage(
    SetLanguageEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(language: event.language));
    final instance = await preferenceInstance;
    instance.setString('Language', state.language);
  }

  Future<void> _fetchLanguage(
    FetchLanguageDetails event,
    Emitter<SettingsState> emit,
  ) async {
    final instance = await preferenceInstance;
    final language = instance.getString('Language');
    emit(state.copyWith(language: language));
  }
}
