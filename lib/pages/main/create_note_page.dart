// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:llapp/constants/colors.dart';
import 'package:llapp/pages/main/notes_page.dart';
import 'package:llapp/services/database_service.dart';
import 'package:llapp/widgets/general_widgets.dart/modified_text.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final DatabaseService db =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  String title = "";
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: scaffolBackgroundColor,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  final result = await db.createNewNote(title, text);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const NotesPage()),
                    (route) => false,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(result),
                    backgroundColor: Colors.green,
                  ));
                },
                icon: const Icon(
                  Icons.save,
                  color: secondaryColor,
                ))
          ],
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
            text: "Create Note",
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
                onChanged: (value) {
                  title = value;
                },
                cursorColor: primaryColor,
                style: GoogleFonts.nunito(
                    color: secondaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w800),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: GoogleFonts.nunito(
                      color: secondaryColor.withOpacity(0.2), fontSize: 18),
                ),
              ),
              Divider(
                color: secondaryColor.withOpacity(0.1),
              ),
              TextField(
                onChanged: (value) {
                  text = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: primaryColor,
                style: GoogleFonts.nunito(
                    color: secondaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: "Start typing...",
                  hintStyle: GoogleFonts.nunito(
                    color: secondaryColor.withOpacity(0.2),
                    fontSize: 18,
                  ),
                  border: InputBorder.none,
                ),
              )
            ],
          ),
        ));
  }
}
