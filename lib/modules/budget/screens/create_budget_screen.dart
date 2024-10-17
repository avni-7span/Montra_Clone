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
import 'package:montra_clone/modules/budget/models/budget_data_model.dart';
import 'package:montra_clone/modules/budget/widgets/custom_app_bar.dart';
import 'package:montra_clone/modules/budget/widgets/slider_widget.dart';
import 'package:montra_clone/modules/budget/widgets/switch_list_tile.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/custom_drop_down_field.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/success_dialogue.dart';

@RoutePage()
class CreateBudgetScreen extends StatelessWidget implements AutoRouteWrapper {
  const CreateBudgetScreen({
    super.key,
    @PathParam() this.budgetModel,
  });

  final dynamic budgetModel;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final budgetData = budgetModel as BudgetDataModel?;
        final alertLimit = budgetData != null ? budgetData.alertLimit : 20.0;
        final shouldReceiveAlert =
            budgetData == null ? false : budgetData.shouldReceiveAlert;
        return BudgetBloc()
          ..add(LoadCategoryList())
          ..add(SliderChangeEvent(sliderValue: alertLimit))
          ..add(ReceiveAlertSwitchChangeEvent(
            shouldReceiveAlert: shouldReceiveAlert,
          ));
      },
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final budgetData = budgetModel as BudgetDataModel?;
    return BlocListener<BudgetBloc, BudgetState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status == BudgetStateStatus.failure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showTheSnackBar(
            message: state.errorMessage,
            context: context,
            isBehaviourFloating: false,
          );
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
        } else if (state.status == BudgetStateStatus.updatedSuccessfully) {
          await showDialog(
            context: context,
            builder: (context) => SuccessDialogue(
              successMessage: 'Budget updated successfully',
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
            _AmountTextField(
              budgetDataModel: budgetData,
            ),
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
                            _CategoryDropDownField(
                              budgetDataModel: budgetData,
                            ),
                            _SwitchListTile(
                              budgetDataModel: budgetData,
                            ),
                            const SizedBox(height: 20),
                            if (state.shouldReceiveAlert)
                              ShowSlider(
                                budgetDataModel: budgetData,
                              ),
                            const SizedBox(height: 20),
                            _ContinueButton(
                              budgetDataModel: budgetData,
                            ),
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
  const _AmountTextField({
    super.key,
    required this.budgetDataModel,
  });

  final BudgetDataModel? budgetDataModel;

  @override
  Widget build(BuildContext context) {
    final initialValue = budgetDataModel?.budgetAmount.toStringAsFixed(0);
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        return AmountTextField(
          initialValue: initialValue,
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

class _CategoryDropDownField extends StatelessWidget {
  const _CategoryDropDownField({
    super.key,
    required this.budgetDataModel,
  });

  final BudgetDataModel? budgetDataModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        return AbsorbPointer(
          absorbing: budgetDataModel == null ? false : true,
          child: CustomDropDownField(
            onChanged: (value) {
              context.read<BudgetBloc>().add(SetCategoryEvent(category: value));
            },
            options: budgetDataModel == null
                ? state.categoryList
                : [budgetDataModel!.category],
            selectedValue: budgetDataModel == null
                ? state.category
                : budgetDataModel!.category,
            labelText: 'Choose Category',
          ),
        );
      },
    );
  }
}

class _SwitchListTile extends StatelessWidget {
  const _SwitchListTile({
    super.key,
    required this.budgetDataModel,
  });

  final BudgetDataModel? budgetDataModel;

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
  const ShowSlider({
    super.key,
    required this.budgetDataModel,
  });

  final BudgetDataModel? budgetDataModel;

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
  const _ContinueButton({
    super.key,
    required this.budgetDataModel,
  });

  final BudgetDataModel? budgetDataModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        return CustomElevatedButton(
          buttonLabel: state.status == BudgetStateStatus.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ButtonTitle(
                  isPurple: true,
                  buttonLabel: budgetDataModel == null ? 'Continue' : 'Update',
                ),
          isPurple: true,
          onPressed: () => state.status == BudgetStateStatus.loading
              ? () {}
              : budgetDataModel == null
                  ? context.read<BudgetBloc>().add(ContinueButtonTapEvent())
                  : context.read<BudgetBloc>().add(UpdateBudgetEvent(
                        budgetID: budgetDataModel!.budgetId,
                        budgetAmount: budgetDataModel!.budgetAmount,
                      )),
        );
      },
    );
  }
}
