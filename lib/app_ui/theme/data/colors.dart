// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class AppColorsData extends Equatable {
  const AppColorsData({
    required this.primary,
    required this.violet80,
    required this.violet60,
    required this.violet40,
    required this.violet20,
    required this.yellow100,
    required this.yellow80,
    required this.yellow60,
    required this.yellow40,
    required this.yellow20,
    required this.blue100,
    required this.blue80,
    required this.blue60,
    required this.blue40,
    required this.blue20,
    required this.red100,
    required this.red80,
    required this.red60,
    required this.red40,
    required this.red20,
    required this.green100,
    required this.green80,
    required this.green60,
    required this.green40,
    required this.green20,
    required this.dark100,
    required this.dark75,
    required this.dark50,
    required this.dark25,
    required this.light100,
    required this.light80,
    required this.light60,
    required this.light40,
    required this.light20,
  });

  factory AppColorsData.light() => const AppColorsData(
        primary: Color(0xff7F3DFF),
        violet80: Color(0xff8F57FF),
        violet60: Color(0xffB18AFF),
        violet40: Color(0xffD3BDFF),
        violet20: Color(0xffEEE5FF),
        yellow100: Color(0xffFCAC12),
        yellow80: Color(0xffFCBB3C),
        yellow60: Color(0xffFCCC6F),
        yellow40: Color(0xffFCDDA1),
        yellow20: Color(0xffFCEED4),
        blue100: Color(0xff0077FF),
        blue80: Color(0xff248AFF),
        blue60: Color(0xff57A5FF),
        blue40: Color(0xff8AC0FF),
        blue20: Color(0xffBDDCFF),
        red100: Color(0xffFD3C4A),
        red80: Color(0xffFD5662),
        red60: Color(0xffFD6F7A),
        red40: Color(0xffFDA2A9),
        red20: Color(0xffFDD5D7),
        green100: Color(0xff00A86B),
        green80: Color(0xff2AB784),
        green60: Color(0xff65D1AA),
        green40: Color(0xff93EACA),
        green20: Color(0xffCFFAEA),
        dark100: Color(0xff0D0E0F),
        dark75: Color(0xff161719),
        dark50: Color(0xff464A4D),
        dark25: Color(0xff7A7E80),
        light100: Color(0xffFFFFFF),
        light80: Color(0xffFBFBFB),
        light60: Color(0xffF7F9FA),
        light40: Color(0xffF2F4F5),
        light20: Color(0xffE3E5E5),
      );
  factory AppColorsData.dark() => const AppColorsData(
        primary: Color(0xff7F3DFF),
        violet80: Color(0xff8F57FF),
        violet60: Color(0xffB18AFF),
        violet40: Color(0xffD3BDFF),
        violet20: Color(0xffEEE5FF),
        yellow100: Color(0xffFCAC12),
        yellow80: Color(0xffFCBB3C),
        yellow60: Color(0xffFCCC6F),
        yellow40: Color(0xffFCDDA1),
        yellow20: Color(0xffFCEED4),
        blue100: Color(0xff0077FF),
        blue80: Color(0xff248AFF),
        blue60: Color(0xff57A5FF),
        blue40: Color(0xff8AC0FF),
        blue20: Color(0xffBDDCFF),
        red100: Color(0xffFD3C4A),
        red80: Color(0xffFD5662),
        red60: Color(0xffFD6F7A),
        red40: Color(0xffFDA2A9),
        red20: Color(0xffFDD5D7),
        green100: Color(0xff00A86B),
        green80: Color(0xff2AB784),
        green60: Color(0xff65D1AA),
        green40: Color(0xff93EACA),
        green20: Color(0xffCFFAEA),
        dark100: Color(0xff0D0E0F),
        dark75: Color(0xff161719),
        dark50: Color(0xff464A4D),
        dark25: Color(0xff7A7E80),
        light100: Color(0xffFFFFFF),
        light80: Color(0xffFBFBFB),
        light60: Color(0xffF7F9FA),
        light40: Color(0xffF2F4F5),
        light20: Color(0xffE3E5E5),
      );

  final Color primary;
  final Color violet80;
  final Color violet60;
  final Color violet40;
  final Color violet20;
  final Color yellow100;
  final Color yellow80;
  final Color yellow60;
  final Color yellow40;
  final Color yellow20;
  final Color blue100;
  final Color blue80;
  final Color blue60;
  final Color blue40;
  final Color blue20;
  final Color red100;
  final Color red80;
  final Color red60;
  final Color red40;
  final Color red20;
  final Color green100;
  final Color green80;
  final Color green60;
  final Color green40;
  final Color green20;
  final Color dark100;
  final Color dark75;
  final Color dark50;
  final Color dark25;
  final Color light100;
  final Color light80;
  final Color light60;
  final Color light40;
  final Color light20;

  @override
  List<Object> get props {
    return [
      primary,
      violet80,
      violet60,
      violet40,
      violet20,
      yellow100,
      yellow80,
      yellow60,
      yellow40,
      yellow20,
      blue100,
      blue80,
      blue60,
      blue40,
      blue20,
      red100,
      red80,
      red60,
      red40,
      red20,
      green100,
      green80,
      green60,
      green40,
      green20,
      dark100,
      dark75,
      dark50,
      dark25,
      light100,
      light80,
      light60,
      light40,
      light20,
    ];
  }
}
