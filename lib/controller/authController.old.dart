// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fixmasters_user_app/view/screens/auth_screen/otpPage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class AuthController extends GetxController {
//   static AuthController instance = Get.find();
//   late Rx<User?> _user;
//
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   late RxBool isLoading = false.obs;
//
//   @override
//   void onReady() {
//     super.onReady();
//     _user = Rx<User?>(firebaseAuth.currentUser);
//     _user.bindStream(firebaseAuth.userChanges());
//     ever(_user,
//         _initalScreen); //what ever is notified from bindStream, it gets affected by teh initialscreen function
//   }
//
//   _initalScreen(User? user) {
//     if (user == null) {
//       Get.snackbar('Auth', 'Login');
//       Get.offAllNamed('/login');
//     } else {
//       Get.offAllNamed('/');
//     }
//   }
//
//   void registerUser(String fullName, String email, String password, String phoneNumber) async{
//     try {
//       // Start phone number verification
//       await firebaseAuth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await firebaseAuth.signInWithCredential(credential);
//           // After verification, create user with email/password
//           await firebaseAuth.createUserWithEmailAndPassword(
//             email: email,
//             password: password,
//           );
//           // Add user to Firestore or perform any other actions
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           // Handle verification failure
//           Get.snackbar(
//             'Auth',
//             'Phone Verification Failed',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: Colors.red,
//             messageText: Text(e.message ?? 'An error occurred during phone verification.'),
//           );
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           Get.to(OtpPage(verificationId: verificationId, phoneNumber: phoneNumber),transition: Transition.rightToLeftWithFade);
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           // Handle auto retrieval timeout
//         },
//       );
//     } catch (e) {
//       Get.snackbar(
//         'Auth',
//         'SignUpError',
//         snackPosition: SnackPosition.BOTTOM,
//         titleText: Text('Account Creation Fail'),
//         backgroundColor: Colors.red,
//         messageText: Text(e.toString()),
//       );
//     }
//   }
//
//
//   void signInUser(String email, String password){
//     try{
//       firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//     }catch(e){
//       Get.snackbar('Auth', 'LogInError',
//           snackPosition: SnackPosition.BOTTOM,
//           titleText: Text('Account Login Fail'),
//           backgroundColor: Colors.red,
//           messageText: Text(e.toString()));
//     }
//   }
//
//   void verifyOtp({
//     required BuildContext context,
//     required String verificationId,
//     required String userOtp,
//     required Function onSuccess
// }) async{
//     isLoading.value = true;
//     update();
//     try{
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOtp);
//        User? user =  (await firebaseAuth.signInWithCredential(credential)).user!;
//
//        if(user != null){
//
//          _user.value = user;
//          onSuccess();
//        }
//        isLoading.value = false;
//         update();
//     }on FirebaseAuthException catch(e){
//       Get.snackbar('Auth', e.message.toString(),
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red);
//       isLoading.value = false;
//       update();
//
//     }
//   }
//
//   Future<bool> checkExistingUser() async{
//     DocumentSnapshot snapshot = await firebaseFirestore.collection('users').doc(_user.value?.uid).get();
//     if(snapshot.exists){
//       print('User Exists');
//       return true;
//     }
//     else{
//       print('User Doesnt exist');
//       return false;
//     }
//   }
// }
