import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService(this.uid);

  User? user = FirebaseAuth.instance.currentUser;

  //references of our collections

  //notes collection
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection("notes");

  //user collection
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection("users");

  /* 
  - Notlar önce ayrı bir klasörde tutulsun, sonrasında user collectiona eklensin.
  - Her kullanıcı kayıt olduğunda bilgilerini databasee kayıt etmeliyim.
  - Her kullanıcının notes and todos diye listeleri tutulsun verileri oradan çeker oraya yüklerim.
  */

  // it saves the user data when a new user created.
  Future saveUserData(
    String fullName,
    String email,
  ) async {
    return await usersCollection.doc(uid).set({
      "fullName": fullName,
      "email": email,
      "profilePic":
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
      "userId": uid,
      "notes": [],
      "todos": []
    });
  }

  //create a new note
  Future createNewNote(
    String title,
    String text,
  ) async {
    final noteRef = notesCollection.doc();
    final userRef = usersCollection.doc(uid);

    final noteData = {
      "title": title,
      "text": text,
      "createdDate":
          DateTime.now(), // You can change this to a timestamp if needed
      "userId": uid, // Use the uid property of your DatabaseService instance
    };
    await noteRef.set(noteData);

    final noteId = noteRef.id;
    await userRef.update({
      "notes": FieldValue.arrayUnion([noteId])
    });
  }

  //returns the list of notes
  Future<List> getNotes() async {
    DocumentSnapshot doc = await usersCollection.doc(uid).get();

    if (doc.exists) {
      List notes = doc.get("notes");
      return notes;
    } else {
      return [];
    }
  }

  // i need to display the notes in notes list view
}
