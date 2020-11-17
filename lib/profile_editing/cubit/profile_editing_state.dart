part of 'profile_editing_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class ProfileEditingState extends Equatable {
  const ProfileEditingState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.obscuredPassword = true,
    this.obscuredConfirmedPassword = true,
  });

  final Name name;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final bool obscuredPassword;
  final bool obscuredConfirmedPassword;

  bool get isPasswordObscured => obscuredPassword;
  bool get isConfirmedPasswordObscured => obscuredConfirmedPassword;

  @override
  List<Object> get props => [
        name,
        email,
        password,
        confirmedPassword,
        status,
        obscuredPassword,
        obscuredConfirmedPassword
      ];

  ProfileEditingState copyWith({
    Name name,
    Email email,
    Password password,
    ConfirmedPassword confirmedPassword,
    FormzStatus status,
    bool obscuredPassword,
    bool obscuredConfirmedPassword,
  }) {
    return ProfileEditingState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status ?? this.status,
      obscuredPassword: obscuredPassword ?? this.obscuredPassword,
      obscuredConfirmedPassword:
          obscuredConfirmedPassword ?? this.obscuredConfirmedPassword,
    );
  }
}
