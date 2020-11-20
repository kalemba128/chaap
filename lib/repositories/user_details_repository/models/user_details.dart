class UserDetails {
  String name;
  String photo;

  UserDetails({
    this.name,
    this.photo,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'] as String,
      photo: json['photo'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name,
        'photo': this.photo,
      };

  UserDetails copyWith({
    String name,
    String photo,
  }) {
    return UserDetails(
      name: name ?? this.name,
      photo: photo ?? this.photo,
    );
  }
}
