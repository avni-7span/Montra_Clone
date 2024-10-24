import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/modules/settings/bloc/settings_bloc.dart';
import 'package:montra_clone/modules/settings/widgets/custom_list_tile_two.dart';

@RoutePage()
class CurrencyScreen extends StatelessWidget implements AutoRouteWrapper {
  const CurrencyScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc()..add(const FetchCurrencyDetails()),
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
        title: const Text('Currency'),
        leading: IconButton(
          onPressed: () async {
            context.maybePop();
          },
          icon: Icon(Icons.arrow_back, color: AppColors.instance.dark100),
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Column(
            children: [
              CustomListTileTwo(
                onTap: () {
                  context.read<SettingsBloc>().add(
                        const SetCurrencyEvent(currency: 'USD'),
                      );
                },
                title: 'United States (USD \$)',
                trailing: state.currency == 'USD'
                    ? Icon(
                        Icons.check_circle,
                        color: AppColors.instance.primary,
                      )
                    : null,
              ),
              CustomListTileTwo(
                onTap: () {
                  context.read<SettingsBloc>().add(
                        const SetCurrencyEvent(currency: 'Rupee'),
                      );
                },
                title: 'India (Rupee \u{20B9})',
                trailing: state.currency == 'Rupee'
                    ? Icon(
                        Icons.check_circle,
                        color: AppColors.instance.primary,
                      )
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
