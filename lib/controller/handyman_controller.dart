import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixmasters_user_app/model/gig_model.dart';
import 'package:fixmasters_user_app/model/handyman_model.dart';
import 'package:get/get.dart';

class HandymanController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<HandymanModel> handymens = <HandymanModel>[].obs;

  Future<void> fetchNearestHandymen(String location) async {
    try {
      print('Location: $location'); // Debug print
      handymens.clear();

      // Query the Firestore collection for users who are handymen and in the specified location
      QuerySnapshot handymenSnapshot = await _firestore
          .collection('users')
          .where('is_handyman', isEqualTo: true)
          .where('location', isEqualTo: location)
          .get();

      print('Number of handymen documents: ${handymenSnapshot.docs.length}');

      for (DocumentSnapshot handymanDoc in handymenSnapshot.docs) {
        String userId = handymanDoc['uid']; // Assuming uid field

        // Fetch the handyman's data and create a HandymanModel object
        HandymanModel handyman = await getHandymanWithGigs(userId);

        handymens.add(handyman);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch nearest providers');
      handymens.clear(); // Clear documents list on error
    }
  }

  // Function to fetch a handyman's data and gigs (implementation details)
// Function to fetch a handyman's data and gigs (implementation details)
  Future<HandymanModel> getHandymanWithGigs(String userId) async {
    HandymanModel handyman;
    try {
      // Get the handyman document
      DocumentSnapshot handymanDoc = await _firestore.collection('users').doc(userId).get();

      // Check if the document data is not null before casting
      if (handymanDoc.exists && handymanDoc.data() != null) {
        // Convert handyman data to HandymanModel
        handyman = HandymanModel.fromMap(handymanDoc.data() as Map<String, dynamic>);
      } else {
        // Handle the case when data is null
        print("Error: Handyman document data is null for $userId");
        handyman = HandymanModel.fromMap({});
      }

      // Fetch and populate the list of gigs if the handyman document exists
      if (handymanDoc.exists) {
        handyman.gigs = await fetchGigsByHandyman(handyman.uid);
      }
    } catch (e) {
      print("Error fetching data or gigs for handyman $userId: $e");
      handyman = HandymanModel.fromMap({}); // Create an empty model on error
    }
    return handyman;
  }


  // Function to fetch a handyman's gigs based on handyman uid (implementation details)
  Future<List<GigModel>> fetchGigsByHandyman(String handymanUid) async {
    List<GigModel> gigs = [];
    try {
      DocumentReference handymanRef = _firestore.collection('handymen').doc(handymanUid);
      QuerySnapshot gigSnapshot = await handymanRef.collection('gigs').get();

      gigs = gigSnapshot.docs.map((doc) => GigModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print("Error fetching gigs for handyman $handymanUid: $e");
    }
    return gigs;
  }
}
