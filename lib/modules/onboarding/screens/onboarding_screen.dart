import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
            const SizedBox(height: 25),
            CustomElevatedButton(
              buttonLabel: 'Sign up',
              isPurple: true,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              buttonLabel: 'Login',
              isPurple: false,
              onPressed: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
