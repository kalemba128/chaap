part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.passwordObscured = true,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final bool passwordObscured;

  bool get obscure => passwordObscured;

  @override
  List<Object> get props => [email, password, status, passwordObscured];

  LoginState copyWith({
    Email email,
    Password password,
    FormzStatus status,
    bool passwordObscured,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        passwordObscured: passwordObscured ?? this.passwordObscured);
  }
}
