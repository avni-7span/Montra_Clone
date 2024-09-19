import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.onAccountTap,
    required this.onSettingsTap,
    required this.onLogoutTap,
  });

  final VoidCallback onAccountTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.instance.light100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CustomListTile(
            isLogoutTile: false,
            label: 'Account',
            imagePath: walletIconPath,
            onTap: onAccountTap,
          ),
          Divider(
            color: AppColors.instance.light20,
          ),
          _CustomListTile(
            isLogoutTile: false,
            label: 'Settings',
            imagePath: settingsIconPath,
            onTap: onSettingsTap,
          ),
          Divider(
            color: AppColors.instance.light20,
          ),
          _CustomListTile(
            isLogoutTile: true,
            label: 'Logout',
            imagePath: logoutIconPath,
            onTap: onLogoutTap,
          )
        ],
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    super.key,
    required this.isLogoutTile,
    required this.label,
    required this.imagePath,
    required this.onTap,
  });

  final bool isLogoutTile;
  final String label;
  final String imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            margin:
                const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: isLogoutTile
                  ? AppColors.instance.red20
                  : AppColors.instance.violet20,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              imagePath,
              height: 60,
              width: 60,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
