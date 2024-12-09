import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  FirebaseFirestore,
  FirebaseAuth,
  FirebaseOptions,
  FirebaseMessaging,
  GoogleSignIn,
  QuerySnapshot,
  QueryDocumentSnapshot,
  CollectionReference,
  DocumentReference
])
void main() {}
