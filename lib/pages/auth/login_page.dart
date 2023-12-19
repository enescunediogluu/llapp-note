// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:llapp/constants/colors.dart';
import 'package:llapp/pages/auth/register_page.dart';
import 'package:llapp/pages/main/notes_page.dart';
import 'package:llapp/services/auth_service.dart';
import 'package:llapp/widgets/auth_widgets/text_field_widget.dart';
import 'package:llapp/widgets/general_widgets.dart/logo_widget.dart';
import 'package:llapp/widgets/general_widgets.dart/modified_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = "";
  String password = "";
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffolBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 120),
            const LogoWidget(fontSize: 40),
            const SizedBox(height: 30),
            TextFieldWidget(
              textInputType: TextInputType.emailAddress,
              fieldName: "Email Address",
              onChanged: (text) {
                setState(() {
                  email = text;
                });
              },
            ),
            const SizedBox(height: 25),
            TextFieldWidget(
              obscureText: true,
              fieldName: "Password",
              onChanged: (text) {
                setState(() {
                  password = text;
                });
              },
            ),
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: () async {
                final result = await auth.signInWithEmailAndPassword(
                  email,
                  password,
                );
                if (result == true) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const NotesPage(),
                    ),
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: primaryColor,
                      content: Text(result.toString()),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 133, vertical: 12),
                child: ModifiedText(
                  text: "Login",
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ));
              },
              child: const ModifiedText(
                text: "Sign Up",
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void messagedFeedback(String text) {}
}
