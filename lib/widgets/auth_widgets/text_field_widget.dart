import 'package:flutter/material.dart';
import 'package:llapp/constants/colors.dart';
import 'package:llapp/widgets/general_widgets.dart/modified_text.dart';

class TextFieldWidget extends StatefulWidget {
  final String fieldName;
  final bool? obscureText;
  final TextInputType? textInputType;
  final void Function(String) onChanged;
  const TextFieldWidget({
    super.key,
    required this.fieldName,
    this.obscureText = false,
    this.textInputType,
    required this.onChanged,
  });

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ModifiedText(
        text: widget.fieldName,
        color: secondaryColor,
        fontWeight: FontWeight.w700,
      ),
      const SizedBox(height: 10),
      Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          onChanged: widget.onChanged,
          keyboardType: widget.textInputType,
          cursorColor: primaryColor,
          obscureText: widget.obscureText!,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    ]);
  }
}
