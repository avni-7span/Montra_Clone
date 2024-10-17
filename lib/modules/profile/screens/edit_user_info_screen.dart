import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/core/widgets/custom_text_field.dart';
import 'package:montra_clone/core/widgets/error_text.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/success_dialogue.dart';
import 'package:montra_clone/modules/profile/bloc/profile_bloc.dart';

@RoutePage()
class EditUserInfoScreen extends StatelessWidget implements AutoRouteWrapper {
  const EditUserInfoScreen({
    super.key,
    @PathParam() required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status == ProfileStateStatus.failure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showTheSnackBar(
            message: 'Something went wrong',
            context: context,
            isBehaviourFloating: false,
          );
        } else if (state.status == ProfileStateStatus.success) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          await showDialog(
            context: context,
            builder: (context) => SuccessDialogue(
              successMessage: 'Name updated successfully',
              onOkTap: () => context.router.replaceAll([const ProfileRoute()],
                  updateExistingRoutes: false),
            ),
          );
        }
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.instance.light100,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Edit Name'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  editNameIconPath,
                  height: 150,
                  width: size.width - 20,
                ),
                const SizedBox(height: 10),
                _NameField(name: name),
                const SizedBox(height: 60),
                const _UpdateButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context))
        ..add(NameFieldChangeEvent(name: name)),
      // ..add(LoadNameEvent(name)),
      child: this,
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return CustomTextField(
          hintText: 'Enter name',
          errorWidget: state.name.displayError != null
              ? const ErrorText(error: 'Name is required')
              : null,
          onChanged: (value) {
            context.read<ProfileBloc>().add(
                  NameFieldChangeEvent(name: value),
                );
          },
          initialValue: name,
        );
      },
    );
  }
}

class _UpdateButton extends StatelessWidget {
  const _UpdateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return CustomElevatedButton(
            buttonLabel: state.status == ProfileStateStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : const ButtonTitle(isPurple: true, buttonLabel: 'Edit'),
            isPurple: true,
            onPressed: state.status == ProfileStateStatus.loading
                ? () {}
                : () {
                    context.read<ProfileBloc>().add(const UpdateNameEvent());
                  });
      },
    );
  }
}
