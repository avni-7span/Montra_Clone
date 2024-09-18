import 'package:auto_route/auto_route.dart';
import 'package:montra_clone/app/routes/guards/auth_guard.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';

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

        /// Bottom Navigation Bar
        AutoRoute(
          page: BottomNavigationBarRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, guards: [AuthGuard()]),
            AutoRoute(page: TransactionRoute.page),
            AutoRoute(page: BudgetRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),

        AutoRoute(page: ExpenseTrackerRoute.page, path: '/:isExpense'),
      ];
}