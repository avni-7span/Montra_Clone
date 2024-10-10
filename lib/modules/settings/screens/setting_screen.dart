import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/modules/settings/bloc/settings_bloc.dart';
import 'package:montra_clone/modules/settings/widgets/custom_list_tile_one.dart';
import 'package:montra_clone/modules/settings/widgets/custom_list_tile_two.dart';

@RoutePage()
class SettingScreen extends StatelessWidget implements AutoRouteWrapper {
  const SettingScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc()
        ..add(const FetchCurrencyDetails())
        ..add(const FetchLanguageDetails()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.instance.light100,
        appBar: AppBar(
          backgroundColor: AppColors.instance.light100,
          centerTitle: true,
          title: const Text('Settings'),
        ),
        body: Column(
          children: [
            CustomListTileOne(
              title: 'Currency',
              onTap: () => context.router.push(const CurrencyRoute()),
              currentValue: context.watch<SettingsBloc>().state.currency,
            ),
            CustomListTileOne(
              title: 'Language',
              onTap: () => context.router.push(const LanguageRoute()),
              currentValue: context.watch<SettingsBloc>().state.language,
            ),
            CustomListTileTwo(
              title: 'About',
              onTap: () {},
              trailing: SvgPicture.asset(routeIconPath),
            ),
            CustomListTileTwo(
              title: 'Help',
              onTap: () {},
              trailing: SvgPicture.asset(routeIconPath),
            ),
          ],
        ));
  }
}
