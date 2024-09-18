import 'package:flutter/material.dart';

class AppColors {
  /// singleton
  static final AppColors instance = AppColors.internal();
  factory AppColors() => instance;
  AppColors.internal();

  final primary = const Color(0xff7F3DFF);
  final violet80 = const Color(0xff8F57FF);
  final violet60 = const Color(0xffB18AFF);
  final violet40 = const Color(0xffD3BDFF);
  final violet20 = const Color(0xffEEE5FF);
  final yellow100 = const Color(0xffFCAC12);
  final yellow80 = const Color(0xffFCBB3C);
  final yellow60 = const Color(0xffFCCC6F);
  final yellow40 = const Color(0xffFCDDA1);
  final yellow20 = const Color(0xffFCEED4);
  final blue100 = const Color(0xff0077FF);
  final blue80 = const Color(0xff248AFF);
  final blue60 = const Color(0xff57A5FF);
  final blue40 = const Color(0xff8AC0FF);
  final blue20 = const Color(0xffBDDCFF);
  final red100 = const Color(0xffFD3C4A);
  final red80 = const Color(0xffFD5662);
  final red60 = const Color(0xffFD6F7A);
  final red40 = const Color(0xffFDA2A9);
  final red20 = const Color(0xffFDD5D7);
  final green100 = const Color(0xff00A86B);
  final green80 = const Color(0xff2AB784);
  final green60 = const Color(0xff65D1AA);
  final green40 = const Color(0xff93EACA);
  final green20 = const Color(0xffCFFAEA);
  final dark100 = const Color(0xff0D0E0F);
  final dark75 = const Color(0xff161719);
  final dark50 = const Color(0xff464A4D);
  final dark25 = const Color(0xff7A7E80);
  final light100 = const Color(0xffFFFFFF);
  final light80 = const Color(0xffFBFBFB);
  final light60 = const Color(0xffF7F9FA);
  final light40 = const Color(0xffF2F4F5);
  final light20 = const Color(0xffE3E5E5);
}
