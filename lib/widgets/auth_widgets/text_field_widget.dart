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
  bool showPassword = false;

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
          obscureText: widget.obscureText! ? !showPassword : showPassword,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: widget.obscureText!
                ? IconButton(
                    icon: showPassword
                        ? const Icon(Icons.remove_red_eye_outlined)
                        : const Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    ]);
  }
}
