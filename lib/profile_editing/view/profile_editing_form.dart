import 'package:chaap/profile_editing/profile_editing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaap/sign_up/sign_up.dart';
import 'package:formz/formz.dart';

class ProfileEditingForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              _EmailInput(),
              _DescriptionInput(),
              _CodeInput(),
            ],
          ),
        ),
      ),
    );
  }
}

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

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditingCubit, ProfileEditingState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextFormField(
          //onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            suffixIcon: Icon(Icons.edit),
            labelText: 'Your name',
            helperText: '',
            errorText: state.email.invalid ? 'invalid name' : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
