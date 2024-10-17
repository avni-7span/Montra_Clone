import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/constants_strings.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/core/validators/email_validator.dart';
import 'package:montra_clone/core/validators/password_validator.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/core/widgets/custom_text_field.dart';
import 'package:montra_clone/core/widgets/error_text.dart';
import 'package:montra_clone/core/widgets/password_text_field.dart';
import 'package:montra_clone/modules/authentication/signup/bloc/signup_bloc.dart';
import 'package:montra_clone/modules/authentication/signup/widgets/custom_check_list_tile.dart';
import 'package:montra_clone/modules/authentication/widget/custom_rich_text.dart';
import 'package:montra_clone/modules/authentication/signup/widgets/signup_with_google.dart';

@RoutePage()
class SignupScreen extends StatelessWidget implements AutoRouteWrapper {
  const SignupScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(
        authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context),
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == SignUpStateStatus.isNotChecked) {
          return showTheSnackBar(
            message: 'Please read and check the privacy policy',
            context: context,
            isBehaviourFloating: false,
          );
        } else if (state.status == SignUpStateStatus.failure) {
          return showTheSnackBar(
              message: state.error,
              context: context,
              isBehaviourFloating: false);
        } else if (state.status == SignUpStateStatus.success) {
          context.router.replace(const VerificationInfoRoute());
        } else if (state.status == SignUpStateStatus.signupWithGoogleDone) {
          context.router.replaceAll([const BottomNavigationBarRoute()]);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.instance.light100,
        appBar: AppBar(
          backgroundColor: AppColors.instance.light100,
          centerTitle: true,
          title: Text(
            'Sign Up',
            style: TextStyle(
              color: AppColors.instance.primary,
              fontSize: 25,
            ),
          ),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            children: [
              const _NameField(),
              const SizedBox(height: 20),
              const _EmailField(),
              const SizedBox(height: 20),
              const _PasswordField(),
              const SizedBox(height: 20),
              CustomCheckListTile(
                onChanged: (value) {
                  context
                      .read<SignupBloc>()
                      .add(CheckBoxEvent(isChecked: value));
                },
              ),
              const SizedBox(height: 20),
              const _SignupButton(),
              const SizedBox(height: 10),
              Text(
                'OR',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.instance.dark25),
              ),
              const SizedBox(height: 10),
              const GoogleSignUp(),
              const SizedBox(height: 20),
              CustomRichText(
                title: "Already have an account?  ",
                subtitle: 'Login',
                onTap: () async {
                  await context.router.replace(
                    const LoginRoute(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return CustomTextField(
          initialValue: null,
          hintText: 'Name',
          errorWidget: state.name.displayError != null
              ? const ErrorText(error: 'Name is required')
              : null,
          onChanged: (value) {
            context.read<SignupBloc>().add(
                  NameFieldChangeEvent(name: value),
                );
          },
        );
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
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
            context.read<SignupBloc>().add(
                  EmailFieldChangeEvent(email: value),
                );
          },
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return PasswordTextField(
          hintText: 'Password',
          errorWidget: state.password.displayError ==
                  PasswordValidationError.empty
              ? const ErrorText(error: 'Password is required')
              : state.password.displayError == PasswordValidationError.invalid
                  ? const ErrorText(error: invalidPass)
                  : null,
          onChanged: (value) {
            context.read<SignupBloc>().add(
                  PasswordFieldChangeEvent(password: value),
                );
          },
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return CustomElevatedButton(
          buttonLabel: state.status == SignUpStateStatus.loading
              ? CircularProgressIndicator(
                  color: AppColors.instance.light100,
                )
              : const ButtonTitle(
                  isPurple: true,
                  buttonLabel: 'Sign Up',
                ),
          isPurple: true,
          onPressed: () {
            context
                .read<SignupBloc>()
                .add(const SignupAndSendVerificationEmail());
          },
        );
      },
    );
  }
}

class GoogleSignUp extends StatelessWidget {
  const GoogleSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return SignUpWithGoogle(
          onPressed: state.status == SignUpStateStatus.signupWithGoogleLoading
              ? () {}
              : () {
                  context.read<SignupBloc>().add(const SignUpWithGoogleEvent());
                },
          buttonLabel: state.status == SignUpStateStatus.signupWithGoogleLoading
              ? const Center(child: CircularProgressIndicator())
              : const GoogleButtonLabel(),
        );
      },
    );
  }
}
