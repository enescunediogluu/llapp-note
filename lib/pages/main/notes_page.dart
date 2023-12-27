// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:llapp/constants/colors.dart';
import 'package:llapp/pages/main/create_note_page.dart';
import 'package:llapp/pages/main/edit_note_page.dart';
import 'package:llapp/pages/main/settings_page.dart';
import 'package:llapp/services/database_service.dart';
import 'package:llapp/widgets/general_widgets.dart/logo_widget.dart';
import 'package:llapp/widgets/general_widgets.dart/modified_text.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List notes = [];
  final DatabaseService db =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  List<bool> isSelectedList = [];
  int selectedCount = 0;

  void _countSelected() {
    int counter = 0;
    for (var i = 0; i < isSelectedList.length; i++) {
      if (isSelectedList[i] == true) {
        counter++;
      }
    }
    setState(() {
      selectedCount = counter;
    });
  }

  void _multipleDeletion() async {
    for (var i = 0; i < isSelectedList.length; i++) {
      if (isSelectedList[i] == true) {
        final noteId = notes[i]["noteId"];
        await db.deleteNote(noteId);
      }
    }
    setState(() {
      _getNotesFromFirebase();
      selectedCount = 0;
    });
  }

  void _getNotesFromFirebase() async {
    final noteList = await db.getNotes();

    setState(() {
      notes = noteList;
      isSelectedList = List.generate(notes.length, (index) => false);
    });
  }

  @override
  void initState() {
    super.initState();
    _getNotesFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: primaryColor,
          child: const Icon(
            Icons.add,
            size: 40,
            color: secondaryColor,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateNotePage(),
                ));
          },
        ),
        backgroundColor: scaffolBackgroundColor,
        appBar: AppBar(
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                selectedCount == 0
                    ? Container()
                    : ModifiedText(
                        text: selectedCount.toString(),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                IconButton(
                  onPressed: () {
                    _multipleDeletion();
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                _getNotesFromFirebase();
              },
              icon: const Icon(
                Icons.refresh,
                color: secondaryColor,
              ),
            ),
            IconButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ));
              },
              icon: const Icon(
                Icons.settings_outlined,
                color: secondaryColor,
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const LogoWidget(
            alignment: MainAxisAlignment.start,
            fontSize: 35,
          ),
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 20),
          child: RefreshIndicator(
            color: primaryColor,
            backgroundColor: scaffolBackgroundColor,
            onRefresh: () async {
              _getNotesFromFirebase();
              await Future.delayed(const Duration(seconds: 1));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 1),
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.done,
                        color: scaffolBackgroundColor,
                        size: 18,
                      ),
                      SizedBox(width: 5),
                      ModifiedText(
                        text: "Refreshed!",
                        fontWeight: FontWeight.bold,
                        color: scaffolBackgroundColor,
                      ),
                    ],
                  )));
            },
            child: notes.isEmpty
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_add,
                          color: secondaryColor.withOpacity(0.3),
                        ),
                        const SizedBox(width: 8),
                        ModifiedText(
                          text: "There is no notes!",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor.withOpacity(0.3),
                        )
                      ],
                    ),
                  )
                : MasonryGridView.builder(
                    itemCount: notes.length,
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final currentNote = notes[index];
                      final title = currentNote["title"];
                      final text = currentNote["text"];
                      final noteId = currentNote["noteId"];

                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditNotePage(
                              noteTitle: title,
                              noteText: text,
                              noteId: noteId,
                            ),
                          ));
                        },
                        onLongPress: () {
                          setState(() {
                            isSelectedList[index] = !isSelectedList[index];
                            _countSelected();
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2,
                                  color: isSelectedList[index]
                                      ? primaryColor
                                      : scaffolBackgroundColor),
                              color: const Color(0xff2C3639),
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              title == ""
                                  ? Container()
                                  : ModifiedText(
                                      text: title,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      textAlign: TextAlign.start,
                                      color: secondaryColor,
                                    ),
                              const SizedBox(height: 10),
                              ModifiedText(
                                text: text,
                                fontSize: 18,
                                textAlign: TextAlign.start,
                                color: secondaryColor.withOpacity(0.6),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ));
  }
}
