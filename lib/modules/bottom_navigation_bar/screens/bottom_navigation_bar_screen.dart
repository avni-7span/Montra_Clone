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
      homeIndex: 0,
      routes: const [
        HomeRoute(),
        TransactionRoute(),
        BudgetRoute(),
        ProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return BlocBuilder<ConfigurationCubit, ConfigurationState>(
          builder: (context, state) {
            return Scaffold(
              body: child,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                selectedLabelStyle:
                    TextStyle(color: AppColors.instance.primary),
                unselectedLabelStyle: const TextStyle(color: Color(0xffC6C6C6)),
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.instance.light100,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(homeInactiveIconPath),
                    activeIcon: SvgPicture.asset(homeActiveIconPath),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(transactionInactiveIconPath),
                    activeIcon: SvgPicture.asset(transactionActiveIconPath),
                    label: 'Transaction',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(pieChartInactiveIconPath),
                    activeIcon: SvgPicture.asset(pieChartActiveIconPath),
                    label: 'Budget',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(userInactiveIconPath),
                    activeIcon: SvgPicture.asset(userActiveIconPath),
                    label: 'Profile',
                  )
                ],
              ),
              floatingActionButtonLocation: state.shouldShowFabInCentre
                  ? FloatingActionButtonLocation.centerDocked
                  : FloatingActionButtonLocation.endFloat,
              floatingActionButton: const AddTransactionButton(),
            );
          },
        );
      },
    );
  }
}
