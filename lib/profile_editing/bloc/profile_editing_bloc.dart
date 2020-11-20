import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_details_repository/user_details_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chaap/authentication/authentication.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'profile_editing_event.dart';
part 'profile_editing_state.dart';

class ProfileEditingBloc
    extends Bloc<ProfileEditingEvent, ProfileEditingState> {
  ProfileEditingBloc(
      {@required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        super(ProfileEditingState(
            name: Name.dirty(
                authenticationRepository.currentUser.name ?? "John")));

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<ProfileEditingState> mapEventToState(
    ProfileEditingEvent event,
  ) async* {
    if (event is NameChanged) {
      nameChanged(event.value);
    } else if (event is NameUpdated) {
      updateName();
    }
    // TODO: implement mapEventToState
  }

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      nameStatus: Formz.validate([name]),
    ));
  }

  Future<void> updateName() async {
    final name = state.name.value;
    if (!state.nameStatus.isValidated) return;
    emit(state.copyWith(nameStatus: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.updateUserProfile(name: name);
      createUserTest();
      emit(state.copyWith(nameStatus: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(nameStatus: FormzStatus.submissionFailure));
    }
  }

  void createUserTest() {
    final id = _authenticationRepository.currentUser.id;
    print("Create User id: $id");
    UserDetailsRepository userRepo = UserDetailsRepository();
    userRepo.createUserDetails(UserDetails(
        id: id, name: state.name.value, email: "Bro", photo: "gzzz"));

    /* UserDetailsRepository userRepo = UserDetailsRepository();
    userRepo.createUser(
      UserDetails(
          id: "kotek",
          name: "JohnSmith",
          email: "JohnSmith",
          photo: "JohnSmithPhot"),
    );
    }
  */
  }
}
