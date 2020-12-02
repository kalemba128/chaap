export 'models/models.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'models/user_details.dart';

class UserDetailsRepository {
  UserDetailsRepository({@required uid})
      : assert(uid != null),
        _uid = uid;

  final String _uid;

  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users_details');

  Future<void> createUserDetails(UserDetails userDetails) {
    return collection.doc(_uid).set(userDetails.toJson());
  }

  Future<void> updateUserDetails(UserDetails userDetails) async {
    return await collection.doc(_uid).update(userDetails.toJson());
  }

  Stream<UserDetails> getStream() {
    return collection
        .doc(_uid)
        .snapshots()
        .map((event) => UserDetails.fromJson(event.data()));
  }

  Future<UserDetails> currentUserDetails() async {
    final snapshot = await collection.doc(_uid).get();
    return UserDetails.fromJson(snapshot.data());
  }
}
