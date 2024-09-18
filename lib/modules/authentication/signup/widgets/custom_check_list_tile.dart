import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:montra_clone/app/app_colors.dart';

class CustomCheckListTile extends StatefulWidget {
  const CustomCheckListTile({
    super.key,
    required this.onChanged,
  });

  final Function(bool value) onChanged;

  @override
  State<CustomCheckListTile> createState() => _CustomCheckListTileState();
}

class _CustomCheckListTileState extends State<CustomCheckListTile> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = value!;
            });
            widget.onChanged.call(value!);
          },
        ),
        Flexible(
          child: RichText(
            softWrap: true,
            text: TextSpan(
              text: "By signing up, you agree to the ",
              style: TextStyle(color: AppColors.instance.dark25, fontSize: 18),
              children: <TextSpan>[
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  text: ' Terms of Service and Privacy Policy',
                  style: TextStyle(
                    color: AppColors.instance.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
