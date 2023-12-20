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
    try {
      final noteRef = notesCollection.doc();
      final userRef = usersCollection.doc(uid);

      final noteData = {
        "title": title,
        "text": text,
        "createdDate":
            DateTime.now(), // You can change this to a timestamp if needed
        "userId": uid,
        "noteId":
            noteRef.id // Use the uid property of your DatabaseService instance
      };
      await noteRef.set(noteData);

      final noteId = noteRef.id;
      await userRef.update({
        "notes": FieldValue.arrayUnion([noteId])
      });

      return "The note has been saved succesffuly!";
    } on Exception catch (e) {
      return e.toString();
    }
  }

  //returns the list of notes
  Future<List> getNotes() async {
    DocumentSnapshot doc = await usersCollection.doc(uid).get();
    if (doc.exists) {
      List noteIds = doc.get("notes");
      List notes = [];
      for (var id in noteIds) {
        DocumentSnapshot note = await notesCollection.doc(id).get();
        notes.add(note);
      }
      return notes;
    } else {
      return [];
    }
  }

  //delete the notes in firebase
  Future<dynamic> deleteNote(String noteId) async {
    try {
      // Delete the note document from the notes collection
      await notesCollection.doc(noteId).delete();

      // Update the user's notes list by removing the deleted note ID
      final userRef = usersCollection.doc(uid);
      await userRef.update({
        "notes": FieldValue.arrayRemove([noteId])
      });

      return true; // Success
    } on Exception catch (e) {
      // Handle any errors
      print("Error deleting note: $e");
      return "Error deleting note!"; // Indicate failure
    }
  }
}
