import 'package:flutter/material.dart';

class CustomListTileTwo extends StatelessWidget {
  const CustomListTileTwo({
    super.key,
    required this.onTap,
    required this.title,
    required this.trailing,
  });

  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: trailing,
    );
  }
}
