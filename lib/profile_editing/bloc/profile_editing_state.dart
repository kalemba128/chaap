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
  });

  final Name name;
  final FormzStatus nameStatus;

  @override
  List<Object> get props => [name, nameStatus];

  ProfileEditingLoaded copyWith({
    Name name,
    FormzStatus nameStatus,
  }) {
    return ProfileEditingLoaded(
      name: name ?? this.name,
      nameStatus: nameStatus ?? this.nameStatus,
    );
  }
}
