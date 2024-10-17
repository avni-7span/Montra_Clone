import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/constants_strings.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/core/validators/email_validator.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/core/widgets/custom_text_field.dart';
import 'package:montra_clone/core/widgets/error_text.dart';
import 'package:montra_clone/modules/credential_recover/bloc/reset_password_bloc.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget implements AutoRouteWrapper {
  const ForgotPasswordScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthenticationRepository>(context)),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.status == ResetPasswordStateStatus.failure) {
          return showTheSnackBar(
            message: 'Something went wrong, Please Try again later',
            context: context,
            isBehaviourFloating: false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Reset Password'),
          leading: const AutoLeadingButton(),
        ),
        body: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              Text(
                forgotPass,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 30),
              _EmailField(),
              SizedBox(height: 30),
              ContinueButton(),
              SizedBox(height: 30),
              SuccessMessage(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return CustomTextField(
          initialValue: null,
          hintText: 'Email',
          errorWidget: state.email.displayError == EmailValidationError.empty
              ? const ErrorText(error: 'Email is required')
              : state.email.displayError == EmailValidationError.invalid
                  ? const ErrorText(error: 'Invalid email')
                  : null,
          onChanged: (value) {
            context.read<ResetPasswordBloc>().add(
                  EmailFieldChangeEvent(email: value),
                );
          },
        );
      },
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return CustomElevatedButton(
          buttonLabel: state.status == ResetPasswordStateStatus.loading
              ? CircularProgressIndicator(
                  color: AppColors.instance.light100,
                )
              : const ButtonTitle(isPurple: true, buttonLabel: 'Continue'),
          isPurple: true,
          onPressed: state.status == ResetPasswordStateStatus.loading
              ? () {}
              : () {
                  context
                      .read<ResetPasswordBloc>()
                      .add(const SendResetPasswordEmailEvent());
                },
        );
      },
    );
  }
}

class SuccessMessage extends StatelessWidget {
  const SuccessMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        if (state.status == ResetPasswordStateStatus.success) {
          return Text(
            resetPassSuccess,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.instance.violet80,
              fontSize: 20,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
