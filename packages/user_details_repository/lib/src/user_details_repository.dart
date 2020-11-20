import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/user_details.dart';

class UserDetailsRepository {
  UserDetailsRepository({FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('user_details');

  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<DocumentReference> createUserDetails(UserDetails userDetails) {
    return collection.add(userDetails.toJson());
  }

  // 4
  Future<void> updatePet(UserDetails userDetails) async {
    return await collection.doc(userDetails.id).update(userDetails.toJson());
  }

  final FirebaseFirestore _firebaseFirestore;
  /*
  Future<void> createUser(UserDetails userDetails) async {
    try {
      await _firebaseFirestore
          .collection("users_details")
          .doc(userDetails.id)
          .set(<String, String>{
        'email': userDetails.email,
        'name': userDetails.name,
        'photo': userDetails.photo
      });
    } catch (e) {
      print(e);
    }
  }
  */

}
