// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/data/models/access_token.dart';
import 'package:chat_app/data/models/user_presence.dart';

class AuthUser {
  AccessToken? accessToken;
  User? user;
  UserPresence? userPresence;

  AuthUser({
    this.accessToken,
    this.user,
    this.userPresence,
  });

  AuthUser.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'] != null
        ? AccessToken.fromJson(json['accessToken'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    userPresence = json['userPresence'] != null
        ? UserPresence.fromJson(json['userPresence'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? email;
  String? password;
  bool? isDarkMode;
  String? urlImage;
  int? iV;

  User(
      {this.sId,
      this.email,
      this.password,
      this.isDarkMode,
      this.urlImage,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    isDarkMode = json['isDarkMode'];
    urlImage = json['urlImage'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['email'] = email;
    data['password'] = password;
    data['isDarkMode'] = isDarkMode;
    data['urlImage'] = urlImage;
    data['__v'] = iV;
    return data;
  }
}
