import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:llapp/constants/colors.dart';
import 'package:llapp/pages/main/edit_user_info_page.dart';
import 'package:llapp/pages/main/notes_page.dart';
import 'package:llapp/services/auth_service.dart';
import 'package:llapp/services/database_service.dart';
import 'package:llapp/widgets/general_widgets.dart/logo_widget.dart';
import 'package:llapp/widgets/general_widgets.dart/modified_text.dart';

import '../../widgets/general_widgets.dart/settings_tile_widget.dart';
import '../auth/login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AuthService auth = AuthService();
  final DatabaseService db =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  String fullName = "";
  String profilePic = "";
  String email = "";
  String userId = "";
  bool isLoading = true;

  @override
  void initState() {
    _getUserInfoFromDb();
    super.initState();
  }

  _getUserInfoFromDb() async {
    final user = await db.getUserInfo(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      fullName = user["fullName"];
      profilePic = user["profilePic"];
      email = user["email"];
      userId = user["userId"];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffolBackgroundColor,
      appBar: AppBar(
        actions: const [
          Icon(
            Icons.abc,
            color: scaffolBackgroundColor,
            size: 50,
          )
        ],
        backgroundColor: scaffolBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: secondaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const NotesPage(),
              ),
              (route) => false,
            );
          },
        ),
        title: const LogoWidget(
          fontSize: 35,
        ),
      ),
      body: isLoading
          ? null
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    (profilePic == "")
                        ? const CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 80,
                            child: Icon(
                              Icons.person_outline,
                              size: 80,
                              color: secondaryColor,
                            ),
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(profilePic),
                            radius: 80,
                          ),
                    const SizedBox(height: 20),
                    ModifiedText(
                      text: fullName,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 30),
                    SettingsTileWidget(
                      icon: Icons.edit,
                      text: "Edit Profile",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                            fullName: fullName,
                            email: email,
                            uid: userId,
                            profilePic: profilePic,
                          ),
                        ));
                      },
                    ),
                    SettingsTileWidget(
                      icon: Icons.logout,
                      text: "Log Out",
                      onPressed: () async {
                        await auth.signOut();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false);
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
