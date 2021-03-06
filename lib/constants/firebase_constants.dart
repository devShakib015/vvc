import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseConstants {
  FirebaseConstants._();

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  static CollectionReference<Map<String, dynamic>> userCollection =
      firestore.collection('users');
  static CollectionReference<Map<String, dynamic>> userNameCollection =
      firestore.collection('userNames');
}
