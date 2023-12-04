// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:llapp/constants/colors.dart';
import 'package:llapp/pages/auth/login_page.dart';
import 'package:llapp/services/auth_service.dart';
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
    final AuthService auth = AuthService();
    return Scaffold(
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
            onPressed: () {},
            icon: const Icon(
              Icons.edit_document,
              color: secondaryColor,
            ),
          ),
          IconButton(
            onPressed: () async {
              await auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false);
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
