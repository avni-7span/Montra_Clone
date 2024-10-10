import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/core/widgets/amount_text_field.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/modules/budget/bloc/budget_bloc.dart';
import 'package:montra_clone/modules/budget/widgets/custom_app_bar.dart';
import 'package:montra_clone/modules/budget/widgets/slider_widget.dart';
import 'package:montra_clone/modules/budget/widgets/switch_list_tile.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/custom_drop_down_field.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/success_dialogue.dart';

@RoutePage()
class CreateBudgetScreen extends StatelessWidget implements AutoRouteWrapper {
  const CreateBudgetScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => BudgetBloc()..add(LoadCategoryList()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BudgetBloc, BudgetState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status == BudgetStateStatus.failure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showTheSnackBar(message: state.errorMessage, context: context);
        } else if (state.status == BudgetStateStatus.success) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          await showDialog(
            context: context,
            builder: (context) => SuccessDialogue(
              successMessage: 'Budget created successfully',
              onOkTap: () => context.router.replaceAll([const BudgetRoute()],
                  updateExistingRoutes: false),
            ),
          );
        }
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.instance.primary,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: CustomAppBar(
            onBackTap: () async {
              await context.router.replaceAll(
                [const BudgetRoute()],
                updateExistingRoutes: false,
              );
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _EnterAmountText(),
            const _AmountTextField(),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.instance.light100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocBuilder<BudgetBloc, BudgetState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 25),
                            const _CategoryTextField(),
                            const _SwitchListTile(),
                            const SizedBox(height: 20),
                            if (state.shouldReceiveAlert) const ShowSlider(),
                            const SizedBox(height: 20),
                            const _ContinueButton(),
                            const SizedBox(height: 25),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EnterAmountText extends StatelessWidget {
  const _EnterAmountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        'Enter the amount you want to spend',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.instance.light100,
        ),
      ),
    );
  }
}

class _AmountTextField extends StatelessWidget {
  const _AmountTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        return AmountTextField(
          initialValue: null,
          onChanged: (value) {
            context.read<BudgetBloc>().add(
                  AmountTextFieldChangeEvent(
                    amount: value,
                  ),
                );
          },
          errorWidget: state.amount.displayError != null
              ? Text(
                  'Amount is required.',
                  style: TextStyle(
                    color: AppColors.instance.light100,
                  ),
                )
              : null,
        );
      },
    );
  }
}

class _CategoryTextField extends StatelessWidget {
  const _CategoryTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        return CustomDropDownField(
          onChanged: (value) {
            context.read<BudgetBloc>().add(SetCategoryEvent(category: value));
          },
          options: state.categoryList,
          selectedValue: state.category,
          labelText: 'Choose Category',
        );
      },
    );
  }
}

class _SwitchListTile extends StatelessWidget {
  const _SwitchListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        return SwitchListTileWidget(
          value: state.shouldReceiveAlert,
          onChange: (value) {
            context.read<BudgetBloc>().add(
                  ReceiveAlertSwitchChangeEvent(
                    shouldReceiveAlert: value,
                  ),
                );
          },
        );
      },
    );
  }
}

class ShowSlider extends StatelessWidget {
  const ShowSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        return SliderWidget(
          onChanged: (value) {
            context
                .read<BudgetBloc>()
                .add(SliderChangeEvent(sliderValue: value));
          },
          value: state.sliderValue ?? 20,
          label: (state.sliderValue ?? 20).toInt().toString(),
        );
      },
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        return CustomElevatedButton(
          buttonLabel: state.status == BudgetStateStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const ButtonTitle(
                  isPurple: true,
                  buttonLabel: 'Continue',
                ),
          isPurple: true,
          onPressed: () => state.status == BudgetStateStatus.loading
              ? () {}
              : context.read<BudgetBloc>().add(ContinueButtonTapEvent()),
        );
      },
    );
  }
}
