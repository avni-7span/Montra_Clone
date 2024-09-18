import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/modules/bottom_navigation_bar/widgets/add_transaction_buttton.dart';

@RoutePage()
class BottomNavigationBarScreen extends StatelessWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      homeIndex: 0,
      routes: const [
        HomeRoute(),
        TransactionRoute(),
        BudgetRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            selectedLabelStyle: TextStyle(color: AppColors.instance.primary),
            unselectedLabelStyle: const TextStyle(color: Color(0xffC6C6C6)),
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.instance.light100,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                    'assets/icons/bottom_navigation_icons/home.png'),
                activeIcon: Image.asset(
                    'assets/icons/bottom_navigation_icons/home_.png'),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                    'assets/icons/bottom_navigation_icons/transaction.png'),
                activeIcon: Image.asset(
                    'assets/icons/bottom_navigation_icons/transaction_.png'),
                label: 'Transaction',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                    'assets/icons/bottom_navigation_icons/pie-chart.png'),
                activeIcon: Image.asset(
                    'assets/icons/bottom_navigation_icons/pie-chart_.png'),
                label: 'Budget',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                    'assets/icons/bottom_navigation_icons/user.png'),
                activeIcon: Image.asset(
                    'assets/icons/bottom_navigation_icons/user_.png'),
                label: 'Profile',
              )
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const AddTransactionButton(),
        );
      },
    );
  }
}
