import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/modules/settings/bloc/settings_bloc.dart';
import 'package:montra_clone/modules/settings/widgets/custom_list_tile_two.dart';

@RoutePage()
class LanguageScreen extends StatelessWidget implements AutoRouteWrapper {
  const LanguageScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc()
        ..add(
          const FetchLanguageDetails(),
        ),
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
        title: const Text('Language'),
        leading: IconButton(
          onPressed: () async {
            await context.maybePop();
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
                        const SetLanguageEvent(language: 'English'),
                      );
                },
                title: 'English',
                trailing: state.language == 'English'
                    ? Icon(
                        Icons.check_circle,
                        color: AppColors.instance.primary,
                      )
                    : null,
              ),
              CustomListTileTwo(
                onTap: () {
                  context.read<SettingsBloc>().add(
                        const SetLanguageEvent(language: 'Spanish'),
                      );
                },
                title: 'Spanish',
                trailing: state.language == 'Spanish'
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
