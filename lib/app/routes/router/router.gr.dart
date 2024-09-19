// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;
import 'package:montra_clone/modules/authentication/login/screens/login_screen.dart'
    as _i8;
import 'package:montra_clone/modules/authentication/signup/screens/signup_screen.dart'
    as _i12;
import 'package:montra_clone/modules/authentication/signup/screens/verification_info_screen.dart'
    as _i15;
import 'package:montra_clone/modules/bottom_navigation_bar/screens/bottom_navigation_bar_screen.dart'
    as _i1;
import 'package:montra_clone/modules/budget/budget_screen.dart' as _i2;
import 'package:montra_clone/modules/credential_recover/screens/forgot_password_screen.dart'
    as _i5;
import 'package:montra_clone/modules/expense_tracking/screens/expense_tracker_screen.dart'
    as _i4;
import 'package:montra_clone/modules/home/screens/home_screen.dart' as _i6;
import 'package:montra_clone/modules/onboarding/screens/onboarding_screen.dart'
    as _i9;
import 'package:montra_clone/modules/settings/screens/currency_screen.dart'
    as _i3;
import 'package:montra_clone/modules/settings/screens/language_screen.dart'
    as _i7;
import 'package:montra_clone/modules/profile/screens/profile_screen.dart'
    as _i10;
import 'package:montra_clone/modules/settings/screens/setting_screen.dart'
    as _i11;
import 'package:montra_clone/modules/splash_screen.dart' as _i13;
import 'package:montra_clone/modules/transaction/transaction_screen.dart'
    as _i14;

/// generated route for
/// [_i1.BottomNavigationBarScreen]
class BottomNavigationBarRoute extends _i16.PageRouteInfo<void> {
  const BottomNavigationBarRoute({List<_i16.PageRouteInfo>? children})
      : super(
          BottomNavigationBarRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavigationBarRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavigationBarScreen();
    },
  );
}

/// generated route for
/// [_i2.BudgetScreen]
class BudgetRoute extends _i16.PageRouteInfo<void> {
  const BudgetRoute({List<_i16.PageRouteInfo>? children})
      : super(
          BudgetRoute.name,
          initialChildren: children,
        );

  static const String name = 'BudgetRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i2.BudgetScreen();
    },
  );
}

/// generated route for
/// [_i3.CurrencyScreen]
class CurrencyRoute extends _i16.PageRouteInfo<void> {
  const CurrencyRoute({List<_i16.PageRouteInfo>? children})
      : super(
          CurrencyRoute.name,
          initialChildren: children,
        );

  static const String name = 'CurrencyRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i3.CurrencyScreen();
    },
  );
}

/// generated route for
/// [_i4.ExpenseTrackerScreen]
class ExpenseTrackerRoute extends _i16.PageRouteInfo<ExpenseTrackerRouteArgs> {
  ExpenseTrackerRoute({
    _i17.Key? key,
    required bool isExpense,
    List<_i16.PageRouteInfo>? children,
  }) : super(
          ExpenseTrackerRoute.name,
          args: ExpenseTrackerRouteArgs(
            key: key,
            isExpense: isExpense,
          ),
          rawPathParams: {'isExpense': isExpense},
          initialChildren: children,
        );

  static const String name = 'ExpenseTrackerRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ExpenseTrackerRouteArgs>(
          orElse: () => ExpenseTrackerRouteArgs(
              isExpense: pathParams.getBool('isExpense')));
      return _i16.WrappedRoute(
          child: _i4.ExpenseTrackerScreen(
        key: args.key,
        isExpense: args.isExpense,
      ));
    },
  );
}

class ExpenseTrackerRouteArgs {
  const ExpenseTrackerRouteArgs({
    this.key,
    required this.isExpense,
  });

  final _i17.Key? key;

  final bool isExpense;

  @override
  String toString() {
    return 'ExpenseTrackerRouteArgs{key: $key, isExpense: $isExpense}';
  }
}

/// generated route for
/// [_i5.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i16.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return _i16.WrappedRoute(child: const _i5.ForgotPasswordScreen());
    },
  );
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i16.PageRouteInfo<void> {
  const HomeRoute({List<_i16.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return _i16.WrappedRoute(child: const _i6.HomeScreen());
    },
  );
}

/// generated route for
/// [_i7.LanguageScreen]
class LanguageRoute extends _i16.PageRouteInfo<void> {
  const LanguageRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i7.LanguageScreen();
    },
  );
}

/// generated route for
/// [_i8.LoginScreen]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute({List<_i16.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return _i16.WrappedRoute(child: const _i8.LoginScreen());
    },
  );
}

/// generated route for
/// [_i9.OnboardingScreen]
class OnboardingRoute extends _i16.PageRouteInfo<void> {
  const OnboardingRoute({List<_i16.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return _i16.WrappedRoute(child: const _i9.OnboardingScreen());
    },
  );
}

/// generated route for
/// [_i10.ProfileScreen]
class ProfileRoute extends _i16.PageRouteInfo<void> {
  const ProfileRoute({List<_i16.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i11.SettingScreen]
class SettingRoute extends _i16.PageRouteInfo<void> {
  const SettingRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i11.SettingScreen();
    },
  );
}

/// generated route for
/// [_i12.SignupScreen]
class SignupRoute extends _i16.PageRouteInfo<void> {
  const SignupRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return _i16.WrappedRoute(child: const _i12.SignupScreen());
    },
  );
}

/// generated route for
/// [_i13.SplashScreen]
class SplashRoute extends _i16.PageRouteInfo<void> {
  const SplashRoute({List<_i16.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i13.SplashScreen();
    },
  );
}

/// generated route for
/// [_i14.TransactionScreen]
class TransactionRoute extends _i16.PageRouteInfo<void> {
  const TransactionRoute({List<_i16.PageRouteInfo>? children})
      : super(
          TransactionRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i14.TransactionScreen();
    },
  );
}

/// generated route for
/// [_i15.VerificationInfoScreen]
class VerificationInfoRoute extends _i16.PageRouteInfo<void> {
  const VerificationInfoRoute({List<_i16.PageRouteInfo>? children})
      : super(
          VerificationInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerificationInfoRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i15.VerificationInfoScreen();
    },
  );
}
