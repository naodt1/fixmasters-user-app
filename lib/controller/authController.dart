import 'package:fixmasters_user_app/controller/userController.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Rx<User?> _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_firebaseAuth.currentUser);
    _user.bindStream(_firebaseAuth.userChanges());
    ever(_user, _initialScreen); // Update the UI based on user authentication status
  }

  void _initialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed('/login');
    } else {
      Get.offAllNamed('/');
    }
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await Get.find<UserController>().updateActiveStatus(true);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
      throw Exception(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      await Get.find<UserController>().updateActiveStatus(false);
      await _firebaseAuth.signOut();
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
      throw Exception(e);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword({required String fullname, required String email,required String password,required String confirmPassword,required String phoneNumber,required String proPicImg,required bool isHandyman,required String location}) async {
    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      throw Exception('Passwords do not match');
    }

    try {
      QuerySnapshot query = await _firestore.collection('users').where('email', isEqualTo: email).get();
      if (query.docs.isNotEmpty) {
        Get.snackbar('Error', 'Email already exists. Please choose a different one.');
        throw Exception('Email already exists. Please choose a different one.');
      }

      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'fullname': fullname,
        'phone_number': phoneNumber,
        'profilePic': proPicImg,
        'is_online': true,
        'is_handyman': isHandyman,
        'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
        'location': location
      });

      await Get.find<UserController>().updateActiveStatus(true);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred');
      throw Exception(e.message);
    }
  }
}
