import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthServices {
  Future<void> login(BuildContext context, String email, String pass) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Navigator.pop(context);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Navigator.pop(context);
      }
    }
  }

  Future<void> register(BuildContext context, String email, String pass,
      String confirmedPass) async {
    try {
      if (pass == confirmedPass) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);
      } else {
        print('ensure that the confirmPassword and password are equal ');
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> deleteMessage(String messageId) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(messageId)
          .delete();

      print('✅ Message deleted successfully.');
    } catch (e) {
      print('❌ Error deleting message: $e');
      rethrow; // ممكن نرميه لو حابة تعملي catch تاني برا
    }
  }

}
