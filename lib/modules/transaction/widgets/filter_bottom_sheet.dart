import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';
import 'package:montra_clone/core/widgets/button_title.dart';
import 'package:montra_clone/core/widgets/custom_elevated_button.dart';
import 'package:montra_clone/core/widgets/decorated_line.dart';
import 'package:montra_clone/modules/transaction/bloc/transaction_bloc.dart';
import 'package:montra_clone/modules/transaction/widgets/category_drop_down.dart';
import 'package:montra_clone/modules/transaction/widgets/filter_button.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({
    super.key,
    required this.onBackTap,
  });

  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedLine(onTap: onBackTap),
          const SizedBox(height: 15),
          const ResetFilterRow(),
          const SizedBox(height: 20),
          Row(children: [Text('Filter By', style: textStyle)]),
          const SizedBox(height: 15),
          const FilterByRow(),
          const SizedBox(height: 20),
          Row(children: [Text('Sort By', style: textStyle)]),
          const SizedBox(height: 15),
          const SortByRow(),
          const SizedBox(height: 20),
          Row(children: [Text('Category', style: textStyle)]),
          const SizedBox(height: 15),
          CustomCategoryDropDown(),
          const SizedBox(height: 40),
          CustomElevatedButton(
            buttonLabel:
            const ButtonTitle(isPurple: true, buttonLabel: 'Apply'),
            isPurple: true,
            onPressed: () {},
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

final textStyle = TextStyle(
  color: AppColors.instance.dark100,
  fontWeight: FontWeight.bold,
  fontSize: 15,
);

class ResetFilterRow extends StatelessWidget {
  const ResetFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Filter Transaction',
          style: textStyle,
        ),
        FilterButton(
          label: 'Reset',
          isSelected: true,
          onTap: () {},
        )
      ],
    );
  }
}

class FilterByRow extends StatelessWidget {
  const FilterByRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FilterButton(
              label: 'Expense',
              isSelected: state.filterBy == 'Expense',
              onTap: () {
                context
                    .read<TransactionBloc>()
                    .add(const SetFilterByEvent(filterBy: 'Expense'));
              },
            ),
            const SizedBox(width: 10),
            FilterButton(
              label: 'Income',
              isSelected: state.filterBy == 'Income',
              onTap: () {
                context
                    .read<TransactionBloc>()
                    .add(const SetFilterByEvent(filterBy: 'Income'));
              },
            )
          ],
        );
      },
    );
  }
}

class SortByRow extends StatelessWidget {
  const SortByRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterButton(
              label: 'Highest',
              isSelected: state.sortBy == 'Highest',
              onTap: () {
                context
                    .read<TransactionBloc>()
                    .add(const SetSortByEvent(sortBy: 'Highest'));
              },
            ),
            FilterButton(
              label: 'Lowest',
              isSelected: state.sortBy == 'Lowest',
              onTap: () {
                context
                    .read<TransactionBloc>()
                    .add(const SetSortByEvent(sortBy: 'Lowest'));
              },
            ),
            FilterButton(
              label: 'Newest',
              isSelected: state.sortBy == 'Newest',
              onTap: () {
                context
                    .read<TransactionBloc>()
                    .add(const SetSortByEvent(sortBy: 'Newest'));
              },
            ),
            FilterButton(
              label: 'Oldest',
              isSelected: state.sortBy == 'Oldest',
              onTap: () {
                context
                    .read<TransactionBloc>()
                    .add(const SetSortByEvent(sortBy: 'Oldest'));
              },
            )
          ],
        );
      },
    );
  }
}

class CategoryListTile extends StatelessWidget {
  const CategoryListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Choose Category',
          style: TextStyle(fontSize: 15),
        ),
        GestureDetector(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Category',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                routeIconPath,
                height: 23,
                width: 23,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomCategoryDropDown extends StatelessWidget {
  const CustomCategoryDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return CategoryDropDown(
          onChanged: (value) {
            context
                .read<TransactionBloc>()
                .add(SetCategoryFilterEvent(categoryFilter: value));
          },
          options: state.filterBy == 'Expense'
              ? ['Food', 'Subscription', 'Shopping', 'Transportation']
              : ['Salary', 'Rental Income', 'Interest'], //optionList,
          labelText: 'Choose Category',
          selectedValue:
        );
      },
    );
  }
}
