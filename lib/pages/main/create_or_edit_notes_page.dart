import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                cursorColor: primaryColor,
                style: GoogleFonts.nunito(
                    color: secondaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: GoogleFonts.nunito(
                      color: secondaryColor.withOpacity(0.4), fontSize: 22),
                ),
              ),
              Divider(
                color: secondaryColor.withOpacity(0.1),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: primaryColor,
                style: GoogleFonts.nunito(
                    color: secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              )
            ],
          ),
        ));
  }
}
