import 'dart:async';

import 'package:chaap/repositories/authentication_repository/authentication_repository.dart';

import 'package:chaap/repositories/user_details_repository/user_details_repository.dart';
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
        super(ProfileEditingInit());

  final AuthenticationRepository _authenticationRepository;

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
      await updateUserDetails();
      emit(state.copyWith(nameStatus: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(nameStatus: FormzStatus.submissionFailure));
    }
  }

  Future<void> updateUserDetails() async {
    final state = (this.state as ProfileEditingLoaded);
    final uid = _authenticationRepository.currentUser.uid;
    final usrRepo = UserDetailsRepository(uid: uid);
    final details = UserDetails(name: state.name.value, photo: 'newPhoto');
    await usrRepo.updateUserDetails(details);
  }

  Future<void> loadDetails() async {
    final user = _authenticationRepository.currentUser;
    final usrRepo = UserDetailsRepository(uid: user.uid);
    final details = await usrRepo.currentUserDetails();
    emit(ProfileEditingLoaded(name: Name.dirty(details.name)));
  }
}
