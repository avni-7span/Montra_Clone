import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/app/image_paths.dart';

class UserInfoRow extends StatelessWidget {
  const UserInfoRow({
    super.key,
    required this.userName,
    required this.onEditIconTap,
    required this.userEmail,
  });

  final String userName;
  final String userEmail;
  final VoidCallback onEditIconTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          appLogo,
          height: 80,
          width: 140,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      color: AppColors.instance.dark100,
                      fontSize: 25,
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
              padding: const EdgeInsets.only(left: 10),
              child: IconButton(
                onPressed: onEditIconTap,
                icon: SvgPicture.asset(
                  editIconPath,
                  color: AppColors.instance.dark100,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
