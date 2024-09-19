import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';

class CustomListTileOne extends StatelessWidget {
  const CustomListTileOne({
    super.key,
    required this.title,
    required this.onTap,
    required this.currentValue,
  });

  final String title;
  final VoidCallback onTap;
  final String currentValue;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        title: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentValue,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.instance.dark25,
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(routeIconPath),
          ],
        ));
  }
}
