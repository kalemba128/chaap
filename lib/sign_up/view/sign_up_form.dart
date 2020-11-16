import 'package:chaap/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaap/sign_up/sign_up.dart';
import 'package:formz/formz.dart';

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Title(),
              const SizedBox(height: 100),
              _EmailInput(),
              const SizedBox(height: 8.0),
              _PasswordInput(),
              const SizedBox(height: 8.0),
              _ConfirmPasswordInput(),
              const SizedBox(height: 8.0),
              _SignUpButton(),
              const SizedBox(height: 8.0),
              _BackToSingIn(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Create Your Account",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        fontSize: 40,
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            hintText: 'Phone Number or Email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          (previous.password != current.password) ||
          (previous.isPasswordObscured != current.isPasswordObscured),
      builder: (context, state) {
        final theme = Theme.of(context);
        Color eyeColor = theme.accentColor;
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: state.isPasswordObscured,
          decoration: InputDecoration(
            suffixIcon: state.password.value.length > 0
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye_rounded,
                      color: state.isPasswordObscured
                          ? eyeColor.withAlpha(100)
                          : eyeColor,
                    ),
                    onPressed: () =>
                        context.read<SignUpCubit>().passwordVisibilityChanged(),
                  )
                : null,
            prefixIcon: Icon(Icons.lock),
            labelText: 'Password',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          (previous.password != current.password ||
              previous.confirmedPassword != current.confirmedPassword) ||
          (previous.isConfirmedPasswordObscured !=
              current.isConfirmedPasswordObscured),
      builder: (context, state) {
        final theme = Theme.of(context);
        Color eyeColor = theme.accentColor;
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: state.isConfirmedPasswordObscured,
          decoration: InputDecoration(
            suffixIcon: state.confirmedPassword.value.length > 0
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye_rounded,
                      color: state.isConfirmedPasswordObscured
                          ? eyeColor.withAlpha(100)
                          : eyeColor,
                    ),
                    onPressed: () => context
                        .read<SignUpCubit>()
                        .confirmedPasswordVisibilityChanged(),
                  )
                : null,
            prefixIcon: Icon(Icons.lock),
            labelText: 'Confirm Password',
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      key: const Key('signUpForm_continue_raisedButton'),
                      child: const Text('Sign Up'),
                      onPressed: () =>
                          context.read<SignUpCubit>().signUpFormSubmitted(),
                    ),
                  )
                ],
              );
      },
    );
  }
}

class _BackToSingIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).push<void>(LoginPage.route()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back_rounded),
          Text("Back to Sing In"),
        ],
      ),
    );
  }
}
