import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:llapp/constants/colors.dart';

class LogoWidget extends StatelessWidget {
  final double? fontSize;
  final MainAxisAlignment? alignment;
  const LogoWidget({
    super.key,
    this.fontSize,
    this.alignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment!,
      children: [
        Text(
          "LL",
          style: GoogleFonts.titanOne(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              color: primaryColor),
        ),
        Text(
          "APP",
          style: GoogleFonts.titanOne(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              color: secondaryColor),
        )
      ],
    );
  }
}
