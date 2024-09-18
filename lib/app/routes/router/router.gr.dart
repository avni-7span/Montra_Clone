// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:montra_clone/modules/authentication/login/screens/login_screen.dart'
    as _i6;
import 'package:montra_clone/modules/authentication/signup/screens/signup_screen.dart'
    as _i9;
import 'package:montra_clone/modules/authentication/signup/screens/verification_info_screen.dart'
    as _i12;
import 'package:montra_clone/modules/bottom_navigation_bar/screens/bottom_navigation_bar_screen.dart'
    as _i1;
import 'package:montra_clone/modules/budget/budget_screen.dart' as _i2;
import 'package:montra_clone/modules/credential_recover/screens/forgot_password_screen.dart'
    as _i4;
import 'package:montra_clone/modules/expense_tracking/screens/expense_tracker_screen.dart'
    as _i3;
import 'package:montra_clone/modules/home/screens/home_screen.dart' as _i5;
import 'package:montra_clone/modules/onboarding/screens/onboarding_screen.dart'
    as _i7;
import 'package:montra_clone/modules/profile/profile_screen.dart' as _i8;
import 'package:montra_clone/modules/splash_screen.dart' as _i10;
import 'package:montra_clone/modules/transaction/transaction_screen.dart'
    as _i11;

/// generated route for
/// [_i1.BottomNavigationBarScreen]
class BottomNavigationBarRoute extends _i13.PageRouteInfo<void> {
  const BottomNavigationBarRoute({List<_i13.PageRouteInfo>? children})
      : super(
          BottomNavigationBarRoute.name,
          initialChildren: children,
        );

  static const String name = 'BottomNavigationBarRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavigationBarScreen();
    },
  );
}

/// generated route for
/// [_i2.BudgetScreen]
class BudgetRoute extends _i13.PageRouteInfo<void> {
  const BudgetRoute({List<_i13.PageRouteInfo>? children})
      : super(
          BudgetRoute.name,
          initialChildren: children,
        );

  static const String name = 'BudgetRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i2.BudgetScreen();
    },
  );
}

/// generated route for
/// [_i3.ExpenseTrackerScreen]
class ExpenseTrackerRoute extends _i13.PageRouteInfo<ExpenseTrackerRouteArgs> {
  ExpenseTrackerRoute({
    _i14.Key? key,
    required bool isExpense,
    List<_i13.PageRouteInfo>? children,
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

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ExpenseTrackerRouteArgs>(
          orElse: () => ExpenseTrackerRouteArgs(
              isExpense: pathParams.getBool('isExpense')));
      return _i13.WrappedRoute(
          child: _i3.ExpenseTrackerScreen(
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

  final _i14.Key? key;

  final bool isExpense;

  @override
  String toString() {
    return 'ExpenseTrackerRouteArgs{key: $key, isExpense: $isExpense}';
  }
}

/// generated route for
/// [_i4.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i13.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return _i13.WrappedRoute(child: const _i4.ForgotPasswordScreen());
    },
  );
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeScreen();
    },
  );
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i13.PageRouteInfo<void> {
  const LoginRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return _i13.WrappedRoute(child: const _i6.LoginScreen());
    },
  );
}

/// generated route for
/// [_i7.OnboardingScreen]
class OnboardingRoute extends _i13.PageRouteInfo<void> {
  const OnboardingRoute({List<_i13.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return _i13.WrappedRoute(child: const _i7.OnboardingScreen());
    },
  );
}

/// generated route for
/// [_i8.ProfileScreen]
class ProfileRoute extends _i13.PageRouteInfo<void> {
  const ProfileRoute({List<_i13.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i8.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i9.SignupScreen]
class SignupRoute extends _i13.PageRouteInfo<void> {
  const SignupRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return _i13.WrappedRoute(child: const _i9.SignupScreen());
    },
  );
}

/// generated route for
/// [_i10.SplashScreen]
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i10.SplashScreen();
    },
  );
}

/// generated route for
/// [_i11.TransactionScreen]
class TransactionRoute extends _i13.PageRouteInfo<void> {
  const TransactionRoute({List<_i13.PageRouteInfo>? children})
      : super(
          TransactionRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i11.TransactionScreen();
    },
  );
}

/// generated route for
/// [_i12.VerificationInfoScreen]
class VerificationInfoRoute extends _i13.PageRouteInfo<void> {
  const VerificationInfoRoute({List<_i13.PageRouteInfo>? children})
      : super(
          VerificationInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerificationInfoRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.VerificationInfoScreen();
    },
  );
}
