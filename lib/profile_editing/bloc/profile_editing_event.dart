part of 'profile_editing_bloc.dart';

abstract class ProfileEditingEvent extends Equatable {
  const ProfileEditingEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends ProfileEditingEvent {
  const NameChanged(this.value);
  final String value;

  @override
  List<Object> get props => [value];
}

class NameUpdated extends ProfileEditingEvent {
  const NameUpdated();
  @override
  List<Object> get props => [];
}
