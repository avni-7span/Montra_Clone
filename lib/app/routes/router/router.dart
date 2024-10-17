import 'package:auto_route/auto_route.dart';
import 'package:montra_clone/app/routes/guards/auth_guard.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
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
          guards: [AuthGuard()],
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: TransactionRoute.page),
            AutoRoute(page: EmptyRoute.page),
            AutoRoute(page: BudgetRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),

        /// SubRoutes of home route
        AutoRoute(
          page: ExpenseTrackerRoute.page,
          path: '/:isExpense/:transactionModel',
        ),
        AutoRoute(page: ViewAllDataRoute.page),

        /// SubRoutes of profile route
        AutoRoute(page: SettingRoute.page),
        AutoRoute(page: CurrencyRoute.page),
        AutoRoute(page: LanguageRoute.page),
        AutoRoute(page: EditUserInfoRoute.page, path: '/:name'),

        /// SubRoutes of transaction route
        AutoRoute(page: FinancialReportRoute.page),
        AutoRoute(page: AnalysisRoute.page),

        /// SubRoutes of budget route
        AutoRoute(page: CreateBudgetRoute.page, path: '/:budgetModel'),
        AutoRoute(
          page: DetailBudgetRoute.page,
          path: '/:budgetModel/:spentAmount',
        ),
      ];
}

@RoutePage()
class EmptyScreen extends AutoRouter {
  const EmptyScreen({super.key});
}
