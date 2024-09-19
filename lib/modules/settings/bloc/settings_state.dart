part of 'settings_bloc.dart';

enum SettingsStateStatus { initial, loading, success, failure }

class SettingsState extends Equatable {
  const SettingsState(
      {this.status = SettingsStateStatus.initial,
      this.currency = 'USD',
      this.language = 'English'});

  final SettingsStateStatus status;
  final String currency;
  final String language;

  @override
  List<Object?> get props => [status, currency, language];

  SettingsState copyWith({
    SettingsStateStatus? status,
    String? currency,
    String? language,
  }) {
    return SettingsState(
      status: status ?? this.status,
      currency: currency ?? this.currency,
      language: language ?? this.language,
    );
  }
}
