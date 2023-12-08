import 'package:flutter/material.dart';
import 'package:llapp/widgets/general_widgets.dart/modified_text.dart';

import '../../constants/colors.dart';

class SettingsTileWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onPressed;

  const SettingsTileWidget({
    super.key,
    required this.icon,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: secondaryColor, borderRadius: BorderRadius.circular(8)),
          child: Icon(
            icon,
            color: primaryColor,
            size: 30,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ModifiedText(
              text: text,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: secondaryColor,
                ))
          ],
        ),
      ),
    );
  }
}
