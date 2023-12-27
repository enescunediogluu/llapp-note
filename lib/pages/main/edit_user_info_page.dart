import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:llapp/constants/colors.dart';
import 'package:llapp/pages/main/settings_page.dart';
import 'package:llapp/services/database_service.dart';
import 'package:llapp/widgets/auth_widgets/text_field_widget.dart';
import 'package:llapp/widgets/general_widgets.dart/modified_text.dart';

class EditProfilePage extends StatefulWidget {
  final String fullName;
  final String email;
  final String uid;
  final String profilePic;
  const EditProfilePage({
    super.key,
    required this.fullName,
    required this.email,
    required this.uid,
    required this.profilePic,
  });

  @override
  State<EditProfilePage> createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  String profilePic = "";
  String userId = "";
  final DatabaseService db =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();

    _name.text = widget.fullName;
    _email.text = widget.email;

    setState(() {
      profilePic = widget.profilePic;
      userId = widget.uid;
    });

    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  void _takeUpdateProfilePhoto() async {
    await db.updateTheProfilePhoto();
  }

  void _updateUserInfo() async {
    await db.updateUserInfo(_name.text, userId, profilePic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffolBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const ModifiedText(
          text: "Edit Profile",
          fontWeight: FontWeight.w900,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SettingsPage()),
                (route) => false);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: secondaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Stack(
                children: [
                  (profilePic != "")
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(profilePic),
                        )
                      : const CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 80,
                          child: Icon(
                            Icons.person_outline,
                            size: 80,
                            color: secondaryColor,
                          ),
                        ),
                  Positioned(
                      bottom: 0,
                      right: 20,
                      child: CircleAvatar(
                        backgroundColor: secondaryColor,
                        child: IconButton(
                            onPressed: () async {
                              _takeUpdateProfilePhoto();
                            },
                            icon: const Icon(Icons.edit)),
                      ))
                ],
              ),
              const SizedBox(height: 15),
              const ModifiedText(
                text: "Change Photo",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 30),
              TextFieldWidget(
                controller: _name,
                fieldName: "Full Name",
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                controller: _email,
                fieldName: "Email Address",
                onChanged: (value) {},
              ),
              const SizedBox(height: 45),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () {
                    _updateUserInfo();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()),
                        (route) => false);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: ModifiedText(
                          text: "Update",
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
