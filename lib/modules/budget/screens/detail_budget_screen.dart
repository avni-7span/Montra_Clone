import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/app/routes/router/router.gr.dart';
import 'package:montra_clone/core/utils/custom_snackbar.dart';
import 'package:montra_clone/core/widgets/alert_message_container.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/modules/budget/bloc/budget_bloc.dart';
import 'package:montra_clone/modules/budget/models/budget_data_model.dart';
import 'package:montra_clone/modules/budget/widgets/category_card.dart';
import 'package:montra_clone/modules/budget/widgets/linear_progress_bar_widget.dart';
import 'package:montra_clone/modules/expense_tracking/widgets/success_dialogue.dart';

@RoutePage()
class DetailBudgetScreen extends StatefulWidget implements AutoRouteWrapper {
  const DetailBudgetScreen(
      {super.key,
      @PathParam() required this.budgetModel,
      @PathParam() required this.spentAmount});

  final dynamic budgetModel;
  final double spentAmount;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => BudgetBloc(),
      child: this,
    );
  }

  @override
  State<DetailBudgetScreen> createState() => _DetailBudgetScreenState();
}

class _DetailBudgetScreenState extends State<DetailBudgetScreen> {
  Future<void> _showDeleteBottomSheet({
    required BuildContext bottomSheetContext,
    required String budgetId,
  }) async {
    showModalBottomSheet(
      backgroundColor: AppColors.instance.light100,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return AlertMessageContainer(
          title: 'Remove this budget?',
          subTitle: 'Are you sure you want to remove this budget?',
          onDecoratedLineTap: () => bottomSheetContext.maybePop(),
          onNoTap: () => bottomSheetContext.maybePop(),
          onYesTap: () => bottomSheetContext
              .read<BudgetBloc>()
              .add(DeleteBudgetEvent(budgetID: budgetId)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final budgetDataModel = widget.budgetModel as BudgetDataModel;
    final remaining = budgetDataModel.budgetAmount - widget.spentAmount;
    return BlocListener<BudgetBloc, BudgetState>(
      listener: (context, state) async {
        if (state.status == BudgetStateStatus.failure) {
          return showTheSnackBar(
            message: state.errorMessage,
            context: context,
            isBehaviourFloating: false,
          );
        } else if (state.status == BudgetStateStatus.deletedSuccessfully) {
          await showDialog(
            context: context,
            builder: (context) => SuccessDialogue(
              successMessage: 'Budget deleted successfully',
              onOkTap: () => context.router.replaceAll([const BudgetRoute()],
                  updateExistingRoutes: false),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.instance.light100,
        appBar: AppBar(
          backgroundColor: AppColors.instance.light100,
          centerTitle: true,
          title: const Text('Detail Budget'),
          leading: IconButton(
            onPressed: () async {
              await context.router.replaceAll([const BudgetRoute()],
                  updateExistingRoutes: false);
            },
            icon: Icon(Icons.arrow_back, color: AppColors.instance.dark100),
          ),
          actions: [
            IconButton(
              onPressed: () => _showDeleteBottomSheet(
                bottomSheetContext: context,
                budgetId: budgetDataModel.budgetId,
              ),
              icon: SvgPicture.asset(
                trashIconPath,
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                CategoryCard(category: budgetDataModel.category),
                _RemainingAmountText(remaining: remaining),
                _LinearProgressBar(
                  category: budgetDataModel.category,
                  progressValue:
                      widget.spentAmount / budgetDataModel.budgetAmount,
                ),
                const SizedBox(height: 40),
                if (widget.spentAmount > budgetDataModel.budgetAmount)
                  const _AlertContainer(),
                const Spacer(),
                _EditButton(
                  budgetModel: budgetDataModel,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RemainingAmountText extends StatelessWidget {
  const _RemainingAmountText({
    super.key,
    required this.remaining,
  });

  final double remaining;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Remaining',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          const SizedBox(height: 8),
          Text(
            '\u{20B9} ${remaining < 0 ? 0.0 : remaining}',
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 64),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _LinearProgressBar extends StatelessWidget {
  const _LinearProgressBar({
    super.key,
    required this.category,
    required this.progressValue,
  });

  final String category;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return LinearProgressBarWidget(
      color: switch (category) {
        'Shopping' => AppColors.instance.yellow100,
        'Transportation' => AppColors.instance.blue100,
        'Food' => AppColors.instance.red100,
        String() => AppColors.instance.primary
      },
      progressValue: progressValue,
      minHeight: 16,
    );
  }
}

class _AlertContainer extends StatelessWidget {
  const _AlertContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.instance.red100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outlined,
            size: 24,
            color: AppColors.instance.light100,
          ),
          const SizedBox(width: 8),
          Text(
            'You have exceed the budget limit',
            style: TextStyle(
                color: AppColors.instance.light100,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({
    super.key,
    required this.budgetModel,
  });

  final dynamic budgetModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetBloc, BudgetState>(
      builder: (context, state) {
        return CustomElevatedButton(
          buttonLabel: state.status == BudgetStateStatus.loading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.instance.light100,
                  ),
                )
              : const ButtonTitle(
                  isPurple: true,
                  buttonLabel: 'Edit',
                ),
          isPurple: true,
          onPressed: () async {
            await context.pushRoute(
              CreateBudgetRoute(
                budgetModel: budgetModel,
              ),
            );
          },
        );
      },
    );
  }
}
