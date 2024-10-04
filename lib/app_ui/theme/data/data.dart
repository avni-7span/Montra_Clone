import 'package:equatable/equatable.dart';
import 'package:montra_clone/app_ui/theme/data/colors.dart';
import 'package:montra_clone/app_ui/theme/data/typography.dart';

class AppThemeData extends Equatable {
  const AppThemeData({
    required this.colors,
    required this.typography,
  });

  factory AppThemeData.regular() => AppThemeData(
        colors: AppColorsData.light(),
        typography: AppTypographyData.regular(),
      );
  final AppColorsData colors;
  final AppTypographyData typography;

  AppThemeData withColors(AppColorsData colors) {
    return AppThemeData(
      colors: colors,
      typography: typography,
    );
  }

  @override
  List<Object?> get props => [colors, typography];
}
