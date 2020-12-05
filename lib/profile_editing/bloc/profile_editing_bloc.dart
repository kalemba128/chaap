import 'dart:async';
import 'dart:io';

import 'package:chaap/repositories/authentication_repository/authentication_repository.dart';

import 'package:chaap/repositories/user_details_repository/user_details_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chaap/authentication/authentication.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

part 'profile_editing_event.dart';
part 'profile_editing_state.dart';

class ProfileEditingBloc
    extends Bloc<ProfileEditingEvent, ProfileEditingState> {
  ProfileEditingBloc(
      {@required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        _uid = authenticationRepository.currentUser.uid,
        super(ProfileEditingInit());

  final AuthenticationRepository _authenticationRepository;
  final _uid;

  @override
  Stream<ProfileEditingState> mapEventToState(
    ProfileEditingEvent event,
  ) async* {
    if (event is LoadDetails) {
      loadDetails();
    } else if (event is NameChanged) {
      nameChanged(event.value);
    } else if (event is NameUpdated) {
      updateName();
    } else if (event is PhotoChanged) {
      changePhoto();
    }
  }

  void nameChanged(String value) {
    final state = (this.state as ProfileEditingLoaded);
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      nameStatus: Formz.validate([name]),
    ));
  }

  Future<void> updateName() async {
    final state = (this.state as ProfileEditingLoaded);
    final name = state.name.value;
    if (!state.nameStatus.isValidated) return;
    emit(state.copyWith(nameStatus: FormzStatus.submissionInProgress));
    try {
      await updateUserDetails(
          UserDetails(name: state.name.value, photo: state.photoURL));
      emit(state.copyWith(nameStatus: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(nameStatus: FormzStatus.submissionFailure));
    }
  }

  Future<void> updateUserDetails(UserDetails details) async {
    final state = (this.state as ProfileEditingLoaded);
    final uid = _authenticationRepository.currentUser.uid;
    final usrRepo = UserDetailsRepository(uid: uid);
    await usrRepo.updateUserDetails(details);
  }

  Future<void> loadDetails() async {
    final user = _authenticationRepository.currentUser;
    final usrRepo = UserDetailsRepository(uid: user.uid);
    final details = await usrRepo.currentUserDetails();
    emit(ProfileEditingLoaded(
        name: Name.dirty(details.name), photoURL: details.photo));
  }

  Future<void> changePhoto() async {
    final state = (this.state as ProfileEditingLoaded);
    emit(state.copyWith(photoStatus: FormzStatus.submissionInProgress));

    final photoPath = "${_uid}/photo";

    final storage = FirebaseStorage.instance;
    final picker = ImagePicker();
    PickedFile image;

    /// Check Permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      // Select image
      image = await picker.getImage(source: ImageSource.gallery);

      if (image != null) {
        var file = File(image.path);

        // Upload to firebase
        var snapshot = await storage.ref().child(photoPath).putFile(file);
        var downloadURL = await snapshot.ref.getDownloadURL();
        await updateUserDetails(
            UserDetails(name: state.name.value, photo: downloadURL));

        emit(state.copyWith(
            photoStatus: FormzStatus.submissionSuccess, photoURL: downloadURL));
      } else {
        print("No path received");
      }
    } else {
      print("Grant permission and try again.");
    }
  }
}
