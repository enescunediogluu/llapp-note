import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:llapp/constants/colors.dart';
import 'package:llapp/pages/auth/login_page.dart';
import 'package:llapp/pages/main/notes_page.dart';
import 'package:llapp/services/auth_service.dart';
import 'package:llapp/widgets/auth_widgets/text_field_widget.dart';
import 'package:llapp/widgets/general_widgets.dart/logo_widget.dart';
import 'package:llapp/widgets/general_widgets.dart/modified_text.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String fullName = "";
  String email = "deneme";
  String password = "";
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffolBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const LogoWidget(
                  fontSize: 30,
                  alignment: MainAxisAlignment.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                const ModifiedText(
                  text: "Create a free account",
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ModifiedText(
                    text:
                        "Join LLAPP for free. Create and share unlimited notes with your friends.",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 25),
                TextFieldWidget(
                  onChanged: (text) {
                    setState(() {
                      fullName = text;
                      log(fullName);
                    });
                  },
                  fieldName: "Full Name",
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  textInputType: TextInputType.emailAddress,
                  onChanged: (text) {
                    setState(() {
                      email = text;
                      log(email);
                    });
                  },
                  fieldName: "Email Address",
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  obscureText: true,
                  onChanged: (text) {
                    setState(() {
                      password = text;
                      log(password);
                    });
                  },
                  fieldName: "Password",
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                    onPressed: () async {
                      await auth.signUpWithEmailAndPassword(
                        email,
                        password,
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const NotesPage(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: const ModifiedText(
                      text: "Create Account",
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                    },
                    child: const ModifiedText(
                      text: "Already have an account?",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void messagedFeedback(String text) {}
}
