import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class SwitchListTileWidget extends StatelessWidget {
  const SwitchListTileWidget({
    super.key,
    required this.value,
    required this.onChange,
  });

  final Function(bool value) onChange;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChange,
      title: Text(
        'Receive Alert',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: AppColors.instance.dark100,
        ),
      ),
      subtitle: const Text(
        'Receive alert when it reaches some point.',
      ),
      thumbColor: WidgetStatePropertyAll(
        AppColors.instance.light100,
      ),
      trackColor: WidgetStatePropertyAll(
        AppColors.instance.primary,
      ),
    );
  }
}
