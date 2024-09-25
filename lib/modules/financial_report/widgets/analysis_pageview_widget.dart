import 'package:flutter/cupertino.dart';
import 'package:montra_clone/app/app_colors.dart';

class AnalysisPageViewWidget extends StatelessWidget {
  const AnalysisPageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'This Month',
          style: TextStyle(
            color: AppColors.instance.light100.withOpacity(0.8),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
