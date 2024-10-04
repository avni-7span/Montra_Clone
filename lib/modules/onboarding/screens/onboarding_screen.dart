import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/app_ui/widgets/atoms/padding.dart';
import 'package:montra_clone/app_ui/widgets/atoms/spacing.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/modules/onboarding/cubit/onboarding_cubit.dart';
import 'package:montra_clone/modules/onboarding/models/onboarding_content.dart';
import 'package:montra_clone/modules/onboarding/widgets/page_slide_indicator.dart';
import 'package:montra_clone/modules/onboarding/widgets/page_view_card.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget implements AutoRouteWrapper {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: this,
    );
  }
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.light100,
      body: Padding(
        padding: const EdgeInsets.all(Insets.xsmall8),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: 3,
                onPageChanged: (index) {
                  context.read<OnboardingCubit>().setIndex(index: index);
                },
                itemBuilder: (context, index) {
                  return PageViewCard(
                    title: onboardingContentList[index].title,
                    subTitle: onboardingContentList[index].subTitle,
                    imagePath: onboardingContentList[index].imagePath,
                  );
                },
              ),
            ),
            BlocBuilder<OnboardingCubit, OnboardingState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) {
                      return PageSlideIndicator(
                        isCurrentIndex: state.currentIndex == index,
                      );
                    },
                  ),
                );
              },
            ),
            VSpace.large24(),
            CustomElevatedButton(
              buttonLabel: const ButtonTitle(
                isPurple: true,
                buttonLabel: 'Sign Up',
              ),
              isPurple: true,
              onPressed: () async {
                await context.router.replace(const SignupRoute());
              },
            ),
            VSpace.medium16(),
            CustomElevatedButton(
              buttonLabel: const ButtonTitle(
                isPurple: false,
                buttonLabel: 'Login',
              ),
              isPurple: false,
              onPressed: () async {
                await context.router.replace(const LoginRoute());
              },
            ),
            VSpace.large24(),
          ],
        ),
      ),
    );
  }
}
