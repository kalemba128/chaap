import 'package:authentication_repository/authentication_repository.dart';
import 'package:chaap/profile_editing/profile_editing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditingPage extends StatelessWidget {
  const ProfileEditingPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfileEditingPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Your account'),
      ),
      body: BlocProvider<ProfileEditingCubit>(
        create: (_) =>
            ProfileEditingCubit(context.read<AuthenticationRepository>()),
        child: ProfileEditingForm(),
      ),
    );
  }
}
