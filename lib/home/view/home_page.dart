import 'package:chaap/drawer/view/drawer_page.dart';
import 'package:chaap/home/widgets/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chaap/authentication/authentication.dart';
import 'package:chaap/home/home.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
            child: Avatar(photo: user.photo),
            onPressed: () =>
                Navigator.of(context).push<void>(DrawerPage.route())),
        title: const Text('Chats'),
      ),
      body: _MessagesList(),
    );
  }
}

class _MessagesList extends StatelessWidget {
  List<MessageTile> _messages = [
    MessageTile(
      title: "Hello",
      lastMessage: "bra bra bra....",
    ),
    MessageTile(
      title: "Hello",
      lastMessage: "bra bra bra....",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _messages,
    );
  }
}
