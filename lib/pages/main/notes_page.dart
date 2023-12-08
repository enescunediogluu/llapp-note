// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:llapp/constants/colors.dart';
import 'package:llapp/pages/main/create_or_edit_notes_page.dart';
import 'package:llapp/pages/main/settings_page.dart';
import 'package:llapp/widgets/general_widgets.dart/logo_widget.dart';
import 'package:llapp/widgets/general_widgets.dart/modified_text.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          size: 40,
          color: secondaryColor,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const CreateNotePage(),
          ));
        },
      ),
      backgroundColor: scaffolBackgroundColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_outline,
              color: secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CreateNotePage(),
              ));
            },
            icon: const Icon(
              Icons.edit_document,
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
        backgroundColor: scaffolBackgroundColor,
        title: const LogoWidget(
          alignment: MainAxisAlignment.start,
          fontSize: 35,
        ),
      ),
      body: const Center(
        child: ModifiedText(
          text: "HOME PAGE",
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
