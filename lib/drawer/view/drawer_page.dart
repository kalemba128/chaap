import 'package:chaap/profile_editing/profile_editing.dart';
import 'package:chaap/repositories/user_details_repository/user_details_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaap/authentication/authentication.dart';
import 'package:chaap/home/home.dart';

class DrawerPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => DrawerPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () =>
                Navigator.of(context).push<void>(HomePage.route())),
        title: const Text('Me'),
      ),
      body: Column(
        children: [_UserInfo(), _OptionsList()],
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final usrRepo = UserDetailsRepository(uid: user.uid);

    return Column(
      children: [
        Icon(
          Icons.account_circle,
          color: Colors.white,
          size: 150,
        ),
        const SizedBox(height: 4.0),
        StreamBuilder(
          initialData: UserDetails(name: "John"),
          stream: usrRepo.getStream(),
          builder: (_, snapshot) {
            UserDetails details = snapshot.data;
            return Text(details.name, style: textTheme.headline6);
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _Option extends StatelessWidget {
  const _Option(
      {Key key,
      this.icon,
      this.iconColor,
      this.title,
      this.navigateTo,
      this.onTap})
      : super(key: key);

  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget navigateTo;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Icon(icon, color: iconColor),
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(title),
      onTap: navigateTo != null
          ? () => Navigator.of(context)
              .push<void>(MaterialPageRoute<void>(builder: (_) => navigateTo))
          : onTap,
    );
  }
}

class _OptionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        _Option(
          icon: Icons.notifications_active,
          title: "Notifications",
          iconColor: Colors.purple,
          navigateTo: HomePage(),
        ),
        _Option(
          icon: Icons.privacy_tip,
          title: "Privacy",
          iconColor: Colors.blue,
          navigateTo: HomePage(),
        ),
        _Option(
          icon: Icons.edit,
          title: "Edit profie",
          iconColor: Colors.orange,
          navigateTo: ProfileEditingPage(),
        ),
        _Option(
          icon: Icons.list_alt,
          title: "Others",
          iconColor: Colors.green,
          navigateTo: HomePage(),
        ),
        Divider(),
        _Option(
          icon: Icons.exit_to_app,
          title: "Log out",
          iconColor: Colors.grey[800],
          onTap: () => context
              .read<AuthenticationBloc>()
              .add(AuthenticationLogoutRequested()),
        ),
      ],
    );
  }
}
