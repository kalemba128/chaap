part of 'profile_editing_bloc.dart';

abstract class ProfileEditingState extends Equatable {
  const ProfileEditingState();

  @override
  List<Object> get props => [];
}

class ProfileEditingInit extends ProfileEditingState {}

class ProfileEditingLoaded extends ProfileEditingState {
  const ProfileEditingLoaded({
    this.name = const Name.pure(),
    this.nameStatus = FormzStatus.pure,
    this.photoStatus = FormzStatus.pure,
    this.photoURL = "default",
  });

  final Name name;
  final FormzStatus nameStatus;
  final String photoURL;
  final FormzStatus photoStatus;

  @override
  List<Object> get props => [name, nameStatus, photoURL, photoStatus];

  ProfileEditingLoaded copyWith({
    Name name,
    FormzStatus nameStatus,
    String photoURL,
    FormzStatus photoStatus,
  }) {
    return ProfileEditingLoaded(
      name: name ?? this.name,
      nameStatus: nameStatus ?? this.nameStatus,
      photoURL: photoURL ?? this.photoURL,
      photoStatus: photoStatus ?? this.photoStatus,
    );
  }
}
