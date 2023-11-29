import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> signUpUser(UserModel user) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      await saveUserData(credential.user!.uid, user);
      return credential.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> saveUserData(String userId, UserModel user) async {
    try {
      await _db.collection("Users").doc(userId).set(user.toJson());
    } catch (e) {
      print("Error saving user data: $e");
    }
  }
}
