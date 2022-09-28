// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? sId;
  String username;
  String? email;
  String? password;
  String avatar;
  bool state;
  User({
    this.sId,
    required this.username,
    this.email,
    this.password,
    required this.avatar,
    required this.state,
  });



}
