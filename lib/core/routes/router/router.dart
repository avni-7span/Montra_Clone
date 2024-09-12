import 'package:auto_route/auto_route.dart';
import 'package:montra_clone/core/routes/guards/auth_guard.dart';
import 'package:montra_clone/core/routes/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),

        /// authentication
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SignupRoute.page),

        /// onboarding
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: VerificationInfoRoute.page),

        /// Credential recover
        AutoRoute(page: ForgotPasswordRoute.page),

        /// Home
        AutoRoute(page: HomeRoute.page, guards: [AuthGuard()]),
      ];
}
