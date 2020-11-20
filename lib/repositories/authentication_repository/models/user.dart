import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  const User({
    @required this.uid,
    @required this.email,
  })  : assert(email != null),
        assert(uid != null);

  final String uid;
  final String email;

  static const empty = User(uid: '', email: '');

  @override
  List<Object> get props => [uid, email];
}
