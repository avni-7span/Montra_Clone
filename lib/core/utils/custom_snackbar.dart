import 'package:flutter/material.dart';

void showTheSnackBar(
    {required String message,
    required BuildContext context,
    required bool isBehaviourFloating}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: isBehaviourFloating == false
          ? SnackBarBehavior.fixed
          : SnackBarBehavior.floating,
    ),
  );
}
