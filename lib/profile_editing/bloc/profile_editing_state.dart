part of 'profile_editing_bloc.dart';

class ProfileEditingState extends Equatable {
  const ProfileEditingState({
    this.name = const Name.pure(),
    this.nameStatus = FormzStatus.pure,
  });

  final Name name;
  final FormzStatus nameStatus;

  @override
  List<Object> get props => [name, nameStatus];

  ProfileEditingState copyWith({
    Name name,
    FormzStatus nameStatus,
  }) {
    return ProfileEditingState(
      name: name ?? this.name,
      nameStatus: nameStatus ?? this.nameStatus,
    );
  }
}
