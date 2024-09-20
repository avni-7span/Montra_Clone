import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';

class UserInfoRow extends StatelessWidget {
  const UserInfoRow({
    super.key,
    required this.userName,
    required this.onEditIconTap,
    required this.onImageTap,
    required this.userEmail,
  });

  final String userName;
  final String userEmail;
  final VoidCallback onEditIconTap;
  final VoidCallback onImageTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        UserImage(
          onImageTap: onImageTap,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  color: AppColors.instance.dark100,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                userEmail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.instance.dark25,
                  fontSize: 15,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            onPressed: onEditIconTap,
            icon: Image.asset(
              editIconPath,
              color: AppColors.instance.dark100,
            ),
          ),
        )
      ],
    );
  }
}

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
    required this.onImageTap,
  });

  final VoidCallback onImageTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onImageTap,
      child: Container(
        height: 100,
        width: 100,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.instance.primary,
        ),
        child: Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: AppColors.instance.light100,
          ),
          child: CircleAvatar(
            backgroundImage: const AssetImage(fakeUserImagePath),
            backgroundColor: AppColors.instance.violet20,
          ),
        ),
      ),
    );
  }
}
