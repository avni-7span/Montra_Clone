part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class SetCurrencyEvent extends SettingsEvent {
  const SetCurrencyEvent({required this.currency});
  final String currency;

  @override
  List<Object?> get props => [currency];
}

class FetchCurrencyDetails extends SettingsEvent {
  const FetchCurrencyDetails();

  @override
  List<Object?> get props => [];
}

class SetLanguageEvent extends SettingsEvent {
  const SetLanguageEvent({required this.language});
  final String language;

  @override
  List<Object?> get props => [language];
}

class FetchLanguageDetails extends SettingsEvent {
  const FetchLanguageDetails();

  @override
  List<Object?> get props => [];
}
