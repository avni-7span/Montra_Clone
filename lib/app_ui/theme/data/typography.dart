// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class AppTypographyData extends Equatable {
  const AppTypographyData({
    required this.titleX64,
    required this.title32,
    required this.title24,
    required this.title18,
    required this.regular16,
    required this.regular14,
    required this.small13,
    required this.tiny12,
  });
  factory AppTypographyData.regular() => const AppTypographyData(
        titleX64: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w500,
          package: _packageName,
        ),
        title32: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          package: _packageName,
        ),
        title24: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          package: _packageName,
        ),
        title18: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          package: _packageName,
        ),
        regular16: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          package: _packageName,
        ),
        regular14: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          package: _packageName,
        ),
        small13: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          package: _packageName,
        ),
        tiny12: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          package: _packageName,
        ),
      );

  static const _packageName = 'app_ui';

  final TextStyle titleX64;
  final TextStyle title32;
  final TextStyle title24;
  final TextStyle title18;
  final TextStyle regular16;
  final TextStyle regular14;
  final TextStyle small13;
  final TextStyle tiny12;

  @override
  List<Object?> get props => [
        titleX64,
        title32,
        title24,
        title18,
        regular16,
        regular14,
        small13,
        tiny12,
      ];
}
