import 'package:flutter/material.dart';

const _photoSize = 48.0;

class MessageTile extends StatelessWidget {
  const MessageTile({Key key, this.photo, this.title, this.lastMessage})
      : super(key: key);

  final String photo;
  final String title;
  final String lastMessage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.account_circle_rounded,
        size: _photoSize,
        color: Colors.white,
      ),
      title: Text(title),
      subtitle: Text(lastMessage),
      //trailing: Icon(Icons.more_vert),
    );
  }
}
