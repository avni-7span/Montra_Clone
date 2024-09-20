import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/modules/profile/bloc/profile_bloc.dart';
import 'package:montra_clone/modules/profile/widgets/custom_container.dart';
import 'package:montra_clone/modules/profile/widgets/logout_alert_message.dart';
import 'package:montra_clone/modules/profile/widgets/user_info_row.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context),
      )..add(const FetchUserDetailsEvent()),
      child: this,
    );
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _showLogoutBottomSheet(
      {required BuildContext bottomSheetContext}) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return LogoutAlertMessage(
          onDecoratedLineTap: () => bottomSheetContext.maybePop(),
          onNoTap: () => bottomSheetContext.maybePop(),
          onYesTap: () =>
              bottomSheetContext.read<ProfileBloc>().add(const LogoutEvent()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStateStatus.success) {
          context.router.replaceAll([const LoginRoute()]);
        } else if (state.status == ProfileStateStatus.failure) {
          return showTheSnackBar(
            message: 'Could not logout! Please try again later',
            context: context,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.instance.light40,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return UserInfoRow(
                    userName: state.userName ?? 'Unknown',
                    userEmail: state.userEmail ?? '',
                    onEditIconTap: () {},
                    onImageTap: () {},
                  );
                },
              ),
              const SizedBox(height: 30),
              CustomContainer(
                onAccountTap: () {},
                onSettingsTap: () => context.router.push(const SettingRoute()),
                onLogoutTap: () =>
                    _showLogoutBottomSheet(bottomSheetContext: context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
