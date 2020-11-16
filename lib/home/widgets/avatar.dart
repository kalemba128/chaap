import 'package:flutter/material.dart';

const _avatarSize = 48.0;

class Avatar extends StatelessWidget {
  const Avatar({Key key, this.photo}) : super(key: key);

  final String photo;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: _avatarSize,
      backgroundImage: photo != null ? NetworkImage(photo) : null,
      child: photo == null
          ? const Icon(
              Icons.account_circle_rounded,
              size: _avatarSize,
              color: Colors.white,
            )
          : null,
    );
  }
}
