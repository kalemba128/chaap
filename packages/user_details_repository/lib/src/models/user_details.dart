class UserDetails {
  String id;
  String email;
  String name;
  String photo;

  UserDetails({
    this.id,
    this.email,
    this.name,
    this.photo,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photo: json['photo'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'name': this.name,
        'email': this.email,
        'photo': this.photo,
      };
}
