import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class CurrentFilterContainer extends StatelessWidget {
  const CurrentFilterContainer({
    super.key,
    required this.filterTitle,
  });

  final String filterTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: AppColors.instance.dark25,
        ),
      ),
      child: Center(
        child: Text(
          filterTitle,
          style: TextStyle(
            color: AppColors.instance.primary,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
