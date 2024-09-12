// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:montra_clone/modules/authentication/login/screens/login_screen.dart'
    as _i3;
import 'package:montra_clone/modules/authentication/signup/screens/signup_screen.dart'
    as _i5;
import 'package:montra_clone/modules/authentication/signup/screens/Verification_info_screen.dart'
    as _i7;
import 'package:montra_clone/modules/credential_recover/screens/forgot_password_screen.dart'
    as _i1;
import 'package:montra_clone/modules/home/screens/home_screen.dart' as _i2;
import 'package:montra_clone/modules/onboarding/screens/onboarding_screen.dart'
    as _i4;
import 'package:montra_clone/modules/splash_screen.dart' as _i6;

/// generated route for
/// [_i1.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i8.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return _i8.WrappedRoute(child: const _i1.ForgotPasswordScreen());
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return _i8.WrappedRoute(child: const _i3.LoginScreen());
    },
  );
}

/// generated route for
/// [_i4.OnboardingScreen]
class OnboardingRoute extends _i8.PageRouteInfo<void> {
  const OnboardingRoute({List<_i8.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return _i8.WrappedRoute(child: const _i4.OnboardingScreen());
    },
  );
}

/// generated route for
/// [_i5.SignupScreen]
class SignupRoute extends _i8.PageRouteInfo<void> {
  const SignupRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return _i8.WrappedRoute(child: const _i5.SignupScreen());
    },
  );
}

/// generated route for
/// [_i6.SplashScreen]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashScreen();
    },
  );
}

/// generated route for
/// [_i7.VerificationInfoScreen]
class VerificationInfoRoute extends _i8.PageRouteInfo<void> {
  const VerificationInfoRoute({List<_i8.PageRouteInfo>? children})
      : super(
          VerificationInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerificationInfoRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.VerificationInfoScreen();
    },
  );
}
