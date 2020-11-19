import 'package:chaap/profile_editing/bloc/profile_editing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:formz/formz.dart';

class ProfileEditingForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _NameInput(),
          ],
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<ProfileEditingBloc, ProfileEditingState>(
      buildWhen: (previous, current) =>
          (previous.name != current.name) ||
          (previous.nameStatus != current.nameStatus),
      builder: (context, state) {
        Widget suffixIcon;

        if (state.nameStatus == FormzStatus.pure)
          suffixIcon = Icon(Icons.edit);
        else if (state.nameStatus == FormzStatus.valid)
          suffixIcon = Icon(Icons.check);
        else if (state.nameStatus == FormzStatus.invalid)
          suffixIcon = Icon(Icons.close_rounded);
        else if (state.nameStatus == FormzStatus.submissionInProgress)
          suffixIcon = SizedBox(
            width: 0,
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 30.0,
            ),
          );
        else if (state.nameStatus == FormzStatus.submissionSuccess)
          suffixIcon = Icon(Icons.check_circle_outline, color: Colors.green);
        else if (state.nameStatus == FormzStatus.submissionFailure)
          suffixIcon = Icon(Icons.close_rounded, color: Colors.red);

        return TextFormField(
          onChanged: (name) =>
              context.read<ProfileEditingBloc>().add(NameChanged(name)),
          onEditingComplete: () {
            if (state.name.valid) {
              context.read<ProfileEditingBloc>().add(NameUpdated());
            }
          },
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            suffixIcon: suffixIcon,
            labelText: 'Your name',
            helperText: '',
            hintText: state.name.value,
            errorText: state.name.invalid ? "invalid name" : '',
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        );
      },
    );
  }
}

/*
    return BlocListener<ProfileEditingCubit, ProfileEditingState>(
      listener: (context, state) {},
      child: Container(
        padding: EdgeInsets.all(30),
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Avatar(),
              _NameInput(),
            ],
          ),
        ),
      ),
    );*/

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.account_circle,
      color: Colors.white,
      size: 100,
    );
  }
}
/*


class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          //       onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            suffixIcon: Icon(Icons.edit),
            labelText: 'Your email',
            helperText: '',
            hintText: user.email ?? "email@xd.pl",
            errorText: state.email.invalid ? 'invalid email' : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        );
      },
    );
  }
}

class _DescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          //onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
          keyboardType: TextInputType.text,
          maxLines: 2,
          decoration: InputDecoration(
            labelText: "Your description",
            prefixIcon: Icon(Icons.description),
            helperText: '',
            suffixIcon: Icon(Icons.edit),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        );
      },
    );
  }
}

class _CodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.refresh),
            prefixIcon: Icon(Icons.qr_code),
            hintText: '435ndu3rwd2d23r29j92wd',
            helperText: '',
            labelText: "Your code",
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        );
      },
    );
  }
}
*/
