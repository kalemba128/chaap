import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:chaap/login/login.dart';
import 'package:chaap/sign_up/sign_up.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Logo(),
              const SizedBox(height: 40.0),
              _EmailInput(),
              const SizedBox(height: 8.0),
              _PasswordInput(),
              const SizedBox(height: 40.0),
              _SignInButton(),
              const SizedBox(height: 10.0),
              _SignUpButton(),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: Image.asset(
        'assets/logo.png',
        width: 150,
      ),
      shaderCallback: (bounds) {
        return RadialGradient(
          colors: [Color(0xff0695fb), Color(0xff9b59b6), Color(0xfffe6a5e)],
          stops: [0, 0.65, 1],
          radius: 1.2,
          center: Alignment.bottomLeft,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
    );
  }
}

class _EmailInput extends StatelessWidget {
  final Color enabledColor = Color(0xFFbdc3c7);
  final Color focusedColor = Color(0xFFecf0f1);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        Widget errorSuffix;
        if (state.email.valid)
          errorSuffix = Icon(Icons.check, color: Colors.green);
        if (state.email.invalid && state.email.value.length > 0)
          errorSuffix = Icon(Icons.error, color: theme.errorColor);

        return TextFormField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) {
            return context.read<LoginCubit>().emailChanged(email);
          },
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: focusedColor,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email_outlined,
              color: enabledColor,
            ),
            suffixIcon: errorSuffix,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: enabledColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: focusedColor)),
            labelText: 'Email',
            labelStyle: TextStyle(
              color: enabledColor,
              fontSize: 20,
            ),
            helperText: '',
            errorText: (state.email.invalid && state.email.value.length > 0)
                ? 'invalid email'
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final Color enabledColor = Color(0xFFbdc3c7);
  final Color focusedColor = Color(0xFFecf0f1);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          (previous.password != current.password) ||
          (previous.obscure != current.obscure),
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),

          ///
          obscureText: state.obscure,
          style: TextStyle(
            color: focusedColor,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: enabledColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: focusedColor)),
            suffixIcon: state.password.value.length > 0
                ? IconButton(
                    icon: Icon(
                      Icons.remove_red_eye_rounded,
                      color: state.obscure
                          ? enabledColor.withAlpha(70)
                          : focusedColor,
                    ),
                    onPressed: () =>
                        context.read<LoginCubit>().passwordVisibilityChange(),
                  )
                : null,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: enabledColor,
            ),
            labelText: 'Password',
            labelStyle: TextStyle(
              color: enabledColor,
              fontSize: 20,
            ),
            helperText: '',
            errorText:
                (state.password.invalid && state.password.value.length > 0)
                    ? 'invalid password'
                    : null,
          ),
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          (previous.email != current.email) ||
          (previous.password != current.password),
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      key: const Key('loginForm_continue_raisedButton'),
                      child: Text("Sign in"),
                      onPressed: state.status.isValidated
                          ? () =>
                              context.read<LoginCubit>().logInWithCredentials()
                          : null,
                    ),
                  ),
                ],
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RaisedButton(
            color: Colors.green,
            key: const Key('loginForm_createAccount_flatButton'),
            child: Text("Create account"),
            onPressed: () =>
                Navigator.of(context).push<void>(SignUpPage.route()),
          ),
        ),
      ],
    );
  }
}
