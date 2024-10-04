import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/modules/financial_analysis/widgets/analysis_button.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
    required this.isBudgetType,
    required this.onBudgetTypeTap,
    required this.onCategoryTypeTap,
    required this.onFilterTap,
  });

  final bool isBudgetType;
  final VoidCallback onBudgetTypeTap;
  final VoidCallback onCategoryTypeTap;
  final GestureTapDownCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FilterDropDown(
          onChanged: (String? value) {},
          selectedValue: 'Month',
        ),
        // FilterContainer(
        //   onFilterTap: onFilterTap,
        // ),
        AnalysisButton(
          onBudgetTypeTap: onBudgetTypeTap,
          onCategoryTypeTap: onCategoryTypeTap,
          isBudgetType: isBudgetType,
        ),
      ],
    );
  }
}

// class FilterContainer extends StatelessWidget {
//   const FilterContainer({
//     super.key,
//     required this.onFilterTap,
//   });
//
//   final GestureTapDownCallback onFilterTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: onFilterTap,
//       child: Container(
//         height: 40,
//         width: 96,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(40),
//           border: Border.all(
//             color: AppColors.instance.dark25,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             'Month',
//             style: TextStyle(color: AppColors.instance.primary, fontSize: 18),
//           ),
//         ),
//       ),
//     );
//   }
// }

class FilterDropDown extends StatelessWidget {
  const FilterDropDown({
    super.key,
    this.selectedValue = 'Month',
    required this.onChanged,
  });

  final String selectedValue;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: 100,
      child: Center(
        child: DropdownButtonFormField<String>(
          isExpanded: true,
          value: selectedValue,
          decoration: InputDecoration(
            hintText: selectedValue,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          items: ['Week', 'Month', 'Year'].map((String option) {
            return DropdownMenuItem<String>(
              alignment: Alignment.center,
              value: option,
              child: Text(
                option,
                style: TextStyle(color: AppColors.instance.dark25),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
