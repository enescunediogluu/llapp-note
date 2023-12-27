// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:llapp/constants/colors.dart';
import 'package:llapp/pages/main/notes_page.dart';
import 'package:llapp/services/database_service.dart';

import '../../widgets/general_widgets.dart/modified_text.dart';

class EditNotePage extends StatefulWidget {
  final String noteId;
  final String noteTitle;
  final String noteText;
  const EditNotePage({
    super.key,
    required this.noteId,
    required this.noteTitle,
    required this.noteText,
  });

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  String text = "";
  String title = "";
  String id = "";

  late final TextEditingController _title;
  late final TextEditingController _text;
  final DatabaseService db =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    _title = TextEditingController();
    _text = TextEditingController();

    text = widget.noteText;
    title = widget.noteTitle;
    id = widget.noteId;

    _title.text = title;
    _text.text = text;

    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffolBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final result = await db.updateTheNote(id, title, text);
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
        title: const ModifiedText(
          text: "Edit Note",
          fontWeight: FontWeight.w900,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: secondaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: _title,
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
              controller: _text,
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
      ),
    );
  }
}
