// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Usermodel {
  String? name;
  String email;
  String password;
  String? profilePicture = '';
  String userid;
  Usermodel({
    this.name,
    required this.email,
    required this.password,
    this.profilePicture,
    required this.userid,
  });

  Usermodel copyWith({
    String? name,
    String? email,
    String? password,
    String? profilePicture,
    String? userid,
  }) {
    return Usermodel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePicture: profilePicture ?? this.profilePicture,
      userid: userid ?? this.userid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'profilePicture': profilePicture,
      'userid': userid,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] as String,
      password: map['password'] as String,
      profilePicture: map['profilePicture'] != null
          ? map['profilePicture'] as String
          : null,
      userid: map['userid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usermodel.fromJson(String source) =>
      Usermodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usermodel(name: $name, email: $email, password: $password, profilePicture: $profilePicture, userid: $userid)';
  }

  @override
  bool operator ==(covariant Usermodel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.profilePicture == profilePicture &&
        other.userid == userid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        profilePicture.hashCode ^
        userid.hashCode;
  }
}
