import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/repository/authentication_repository.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/core/validators/email_validator.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/core/widgets/custom_text_field.dart';
import 'package:montra_clone/core/widgets/error_text.dart';
import 'package:montra_clone/core/widgets/password_text_field.dart';
import 'package:montra_clone/modules/authentication/login/bloc/login_bloc.dart';
import 'package:montra_clone/modules/authentication/login/widgets/forgot_password_text.dart';
import 'package:montra_clone/modules/authentication/login/widgets/verification_alert_dialogue.dart';
import 'package:montra_clone/modules/authentication/widget/custom_rich_text.dart';

@RoutePage()
class LoginScreen extends StatefulWidget implements AutoRouteWrapper {
  const LoginScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context),
      ),
      child: this,
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> showUserVerificationAlertDialogue() async {
    return showDialog(
      context: context,
      builder: (ctx) => VerificationAlertDialogue(
        onResendEmailVerificationTap: () => context.read<LoginBloc>().add(
              const SendVerificationEmailEvent(),
            ),
        onClosedTap: () => context.maybePop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status == LoginStateStatus.failure) {
          return showTheSnackBar(
              message: state.error,
              context: context,
              isBehaviourFloating: false);
        } else if (state.status == LoginStateStatus.isNotVerified) {
          await showUserVerificationAlertDialogue();
        } else if (state.status == LoginStateStatus.success) {
          await context.router.replaceAll([const BottomNavigationBarRoute()]);
        } else if (state.status == LoginStateStatus.emailSent) {
          return showTheSnackBar(
            message: 'We have sent you a verification email,Please check inbox',
            context: context,
            isBehaviourFloating: false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.instance.light100,
        extendBody: true,
        body: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Image.asset(
                appLogo,
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 90),
              const _EmailField(),
              const SizedBox(height: 20),
              const _PasswordField(),
              const SizedBox(height: 30),
              const _LoginButton(),
              const SizedBox(height: 20),
              const ForgotPasswordText(),
              const SizedBox(height: 20),
              CustomRichText(
                title: 'Don’t have an account yet? ',
                subtitle: 'Sign Up',
                onTap: () {
                  context.router.replace(
                    const SignupRoute(),
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

class _EmailField extends StatelessWidget {
  const _EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
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
            context.read<LoginBloc>().add(
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
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return PasswordTextField(
          hintText: 'Password',
          errorWidget: state.password.displayError != null
              ? const ErrorText(error: 'Password is required')
              : null,
          onChanged: (value) {
            context.read<LoginBloc>().add(
                  PasswordFieldChangeEvent(password: value),
                );
          },
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return CustomElevatedButton(
          buttonLabel: state.status == LoginStateStatus.loading
              ? CircularProgressIndicator(
                  color: AppColors.instance.light100,
                )
              : const ButtonTitle(
                  isPurple: true,
                  buttonLabel: 'Login',
                ),
          isPurple: true,
          onPressed: state.status == LoginStateStatus.loading
              ? () {}
              : () {
                  context
                      .read<LoginBloc>()
                      .add(const LoginButtonPressedEvent());
                },
        );
      },
    );
  }
}
