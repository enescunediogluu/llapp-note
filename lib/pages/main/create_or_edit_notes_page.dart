import 'package:flutter/material.dart';
import 'package:llapp/constants/colors.dart';
import 'package:llapp/widgets/general_widgets.dart/modified_text.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffolBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: secondaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: scaffolBackgroundColor,
          title: const ModifiedText(
            text: "Edit Note",
            fontWeight: FontWeight.w900,
          ),
          centerTitle: true,
        ),
        body: const Column(
          children: [],
        ));
  }
}
