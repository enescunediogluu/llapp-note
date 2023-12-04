import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:llapp/constants/colors.dart';

class ModifiedText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const ModifiedText({
    super.key,
    required this.text,
    this.fontSize,
    this.color = secondaryColor,
    this.fontWeight,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.nunito(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
      ),
    );
  }
}
