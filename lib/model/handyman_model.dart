import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixmasters_user_app/model/gig_model.dart';

class HandymanModel {
  final String uid;
  final String fullname;
  final String phoneNumber;
  final String profilePic;
  final String isOnline;
  final bool isHandyman;
  final String location;
  final double avgRating; // Assuming average rating is stored as a number
  final int totalJobs; // Assuming total jobs completed is stored as a number
  final String responseTime; // Assuming response time is stored as a string
  List<GigModel> gigs; // List of gigs associated with the handyman

  HandymanModel({
    required this.uid,
    required this.fullname,
    required this.phoneNumber,
    required this.profilePic,
    required this.isOnline,
    required this.isHandyman,
    required this.location,
    required this.avgRating,
    required this.totalJobs,
    required this.responseTime,
    required this.gigs,
  });

  // Factory constructor to create a HandymanModel from a Firestore DocumentSnapshot
  factory HandymanModel.fromMap(Map<String, dynamic> data) {
    return HandymanModel(
      uid: data['uid'] ?? '',
      fullname: data['fullname'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      profilePic: data['profilePic'] ?? '',
      isOnline: data['is_online'] ?? false,
      isHandyman: data['is_handyman'] ?? false,
      location: data['location'] ?? '',
      avgRating: (data['avg_rating'] as num?)?.toDouble() ?? 0.0,
      totalJobs: data['total_jobs']?.toInt() ?? 0,
      responseTime: data['response_time'] ?? '',
      gigs: [], // Initialize gigs as an empty list
    );
  }
}
