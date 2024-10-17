import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/modules/bottom_navigation_bar/cubit/configuration_cubit.dart';
import 'package:montra_clone/modules/bottom_navigation_bar/widgets/add_transaction_buttton.dart';

@RoutePage()
class BottomNavigationBarScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const BottomNavigationBarScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfigurationCubit()..getRemoteConfigValue(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        TransactionRoute(),
        EmptyRoute(),
        BudgetRoute(),
        ProfileRoute(),
      ],
      homeIndex: 0,
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          extendBody: true,
          body: child,
          bottomNavigationBar: BottomAppBar(
            color: AppColors.instance.light100,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomAppBarItem(
                  imagePath: tabsRouter.activeIndex == 0
                      ? homeActiveIconPath
                      : homeInactiveIconPath,
                  label: 'Home',
                  onTap: () {
                    tabsRouter.setActiveIndex(0);
                  },
                ),
                BottomAppBarItem(
                  imagePath: tabsRouter.activeIndex == 1
                      ? transactionActiveIconPath
                      : transactionInactiveIconPath,
                  label: 'Transaction',
                  onTap: () {
                    tabsRouter.setActiveIndex(1);
                  },
                ),
                const SizedBox(width: 20),
                BottomAppBarItem(
                  imagePath: tabsRouter.activeIndex == 3
                      ? pieChartActiveIconPath
                      : pieChartInactiveIconPath,
                  label: 'Budget',
                  onTap: () {
                    tabsRouter.setActiveIndex(3);
                  },
                ),
                BottomAppBarItem(
                  imagePath: tabsRouter.activeIndex == 4
                      ? userActiveIconPath
                      : userInactiveIconPath,
                  label: 'Profile',
                  onTap: () {
                    tabsRouter.setActiveIndex(4);
                  },
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const AddTransactionButton(),
        );
      },
    );
  }
}

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  final String imagePath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
          ),
          const SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}
