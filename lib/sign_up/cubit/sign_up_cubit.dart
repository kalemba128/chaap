import 'package:chaap/repositories/authentication_repository/authentication_repository.dart';
import 'package:chaap/repositories/user_details_repository/user_details_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:chaap/authentication/authentication.dart';
import 'package:formz/formz.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.name,
        email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.name,
        state.email,
        password,
        state.confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.name,
        state.email,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  void passwordVisibilityChanged() {
    final obscure = !state.obscuredPassword;
    emit(state.copyWith(
      obscuredPassword: obscure,
    ));
  }

  void confirmedPasswordVisibilityChanged() {
    final obscure = !state.obscuredConfirmedPassword;
    emit(state.copyWith(
      obscuredConfirmedPassword: obscure,
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUp(
        name: state.name.value,
        email: state.email.value,
        password: state.password.value,
      );

      createUserDetails();

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void createUserDetails() {
    final uid = _authenticationRepository.currentUser.uid;
    UserDetailsRepository usrRepo = UserDetailsRepository(uid: uid);
    UserDetails details =
        UserDetails(name: state.name.value, photo: 'avatarorsth');
    usrRepo.createUserDetails(details);
  }
}
