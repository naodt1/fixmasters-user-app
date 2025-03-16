import 'package:fixmasters_user_app/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../widgets/categoryCard.dart';

class SignupAdditionalInfoPage extends StatefulWidget {
  final String fullname;
  final String email;
  final String password;
  final String profilePic;
  final String phoneNumber;

  const SignupAdditionalInfoPage({
    Key? key,
    required this.fullname,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _SignupAdditionalInfoPageState createState() =>
      _SignupAdditionalInfoPageState();
}

class _SignupAdditionalInfoPageState extends State<SignupAdditionalInfoPage> {
  TextEditingController _gigTextController = TextEditingController();
  AuthController authController = Get.find();
  String? _selectedLocation;
  Map<String, dynamic>? _selectedCategory;

  List<String> addisAbabaSubCities = [
    'Addis Ketema',
    'Akaky Kaliti',
    'Arada',
    'Bole',
    'Gullele',
    'Kirkos',
    'Kolfe Keranio',
    'Lideta',
    'Nifas Silk-Lafto',
    'Yeka'
  ];



  void signUp() async {
    if (_selectedLocation == null) {
      Get.snackbar('Error', 'Please select a location');
      return;
    }
    await authController.signUpWithEmailAndPassword(
      fullname: widget.fullname,
      email: widget.email,
      password: widget.password,
      confirmPassword: widget
          .password, // Confirm password (not needed here as it's already checked)
      proPicImg:widget.profilePic,
      phoneNumber:widget.phoneNumber,
      isHandyman: false,
      location: _selectedLocation!
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ) ,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Additional Information',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 6),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Location'),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedLocation,
                        items: addisAbabaSubCities.map((String location) {
                          return DropdownMenuItem<String>(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: signUp,
                        child: Text('Sign Up'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.0),
                          minimumSize: Size(double.infinity, 0),
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Back to previous step',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
