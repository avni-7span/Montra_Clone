import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/core/widgets/custom_text_field.dart';
import 'package:montra_clone/core/widgets/error_text.dart';
import 'package:montra_clone/modules/expense_tracking/bloc/expense_tracker_bloc.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/amount_text_field.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/custom_drop_down_field.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/success_dialogue.dart';

@RoutePage()
class ExpenseTrackerScreen extends StatefulWidget implements AutoRouteWrapper {
  const ExpenseTrackerScreen({
    super.key,
    @PathParam() required this.isExpense,
  });

  @override
  State<ExpenseTrackerScreen> createState() => _ExpenseTrackerScreenState();

  final bool isExpense;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseTrackerBloc(),
      child: this,
    );
  }
}

class _ExpenseTrackerScreenState extends State<ExpenseTrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseTrackerBloc, ExpenseTrackerState>(
      listener: (context, state) async {
        if (state.status == ExpenseTrackerStateStatus.failure) {
          return showTheSnackBar(
            message: state.errorMessage ?? 'Something went wrong',
            context: context,
          );
        } else if (state.status == ExpenseTrackerStateStatus.success) {
          await showDialog(
            context: context,
            builder: (context) => SuccessDialogue(
              successMessage: 'Data added successfully',
              onOkTap: context.maybePop,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: widget.isExpense
            ? AppColors.instance.red60
            : AppColors.instance.green80,
        appBar: AppBar(
          backgroundColor: widget.isExpense
              ? AppColors.instance.red60
              : AppColors.instance.green80,
          centerTitle: true,
          leading: IconButton(
            onPressed: () async {
              await context.router
                  .replaceAll([const HomeRoute()], updateExistingRoutes: false);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.instance.light100),
          ),
          title: Text(
            widget.isExpense ? 'Expense' : 'Income',
            style: TextStyle(
              color: AppColors.instance.light100,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'How much?',
                style: TextStyle(
                  color: AppColors.instance.light80,
                  fontSize: 18,
                ),
              ),
            ),
            const _AmountTextField(),
            const SizedBox(height: 20),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32),
                    topLeft: Radius.circular(32),
                  ),
                  color: AppColors.instance.light100,
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    top: 24,
                    right: 16,
                    left: 16,
                    bottom: 24,
                  ),
                  children: [
                    _CategoryField(isExpense: widget.isExpense),
                    _DescriptionField(isExpense: widget.isExpense),
                    const SizedBox(height: 100),
                    _ContinueButton(isExpense: widget.isExpense)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AmountTextField extends StatelessWidget {
  const _AmountTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        return AmountTextField(
          onChanged: (value) {
            context.read<ExpenseTrackerBloc>().add(
                  AmountFieldChangeEvent(
                    amount: value,
                  ),
                );
          },
          errorWidget: state.transactionAmount.displayError != null
              ? const Text('Enter the amount')
              : null,
        );
      },
    );
  }
}

class _CategoryField extends StatelessWidget {
  const _CategoryField({super.key, required this.isExpense});

  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        return CustomDropDownField(
          labelText: 'Category',
          options: isExpense
              ? ['Food', 'Subscription', 'Shopping']
              : ['Employment Income', 'Rental Income', 'Interest'],
          selectedValue: state.category,
          onChanged: (value) {
            context
                .read<ExpenseTrackerBloc>()
                .add(SetCategoryEvent(category: value));
          },
        );
      },
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({
    super.key,
    required this.isExpense,
  });

  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        return CustomTextField(
          hintText: 'Description',
          errorWidget: state.description.displayError != null
              ? ErrorText(
                  error: isExpense
                      ? 'Describe where you spend money'
                      : 'Describe the income source')
              : null,
          onChanged: (value) {
            context.read<ExpenseTrackerBloc>().add(
                  DescriptionFieldChangeEvent(description: value),
                );
          },
        );
      },
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({super.key, required this.isExpense});

  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseTrackerBloc, ExpenseTrackerState>(
      builder: (context, state) {
        return CustomElevatedButton(
          buttonLabel: state.status == ExpenseTrackerStateStatus.loading
              ? CircularProgressIndicator(
                  color: AppColors.instance.light100,
                )
              : const ButtonTitle(
                  isPurple: true,
                  buttonLabel: 'Continue',
                ),
          isPurple: true,
          onPressed: () {
            context.read<ExpenseTrackerBloc>().add(
                  AddTransactionToFireStoreEvent(isExpense: isExpense),
                );
          },
        );
      },
    );
  }
}
