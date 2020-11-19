import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template UserDetails}
/// UserDetails model
///
/// [UserDetails.empty] represents an unauthenticated UserDetails.
/// {@endtemplate}
class UserDetails extends Equatable {
  /// {@macro UserDetailsDetails}
  const UserDetails({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.photo,
  })  : assert(email != null),
        assert(id != null);

  /// The current UserDetails's email address.
  final String email;

  /// The current UserDetails's id.
  final String id;

  /// The current UserDetails's name (display name).
  final String name;

  /// Url for the current UserDetails's photo.
  final String photo;

  /// Empty UserDetails which represents an unauthenticated UserDetails.
  static const empty = UserDetails(email: '', id: '', name: null, photo: null);

  @override
  List<Object> get props => [email, id, name, photo];
}
