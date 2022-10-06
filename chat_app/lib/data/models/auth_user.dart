class AuthUser {
  String? accessToken;
  User? user;

  AuthUser({this.accessToken, this.user});

  AuthUser.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? email;
  String? password;
  String? profile;
  int? iV;

  User({this.sId, this.email, this.password, this.profile, this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    password = json['password'];
    profile = json['profile'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['password'] = this.password;
    data['profile'] = this.profile;
    data['__v'] = this.iV;
    return data;
  }
}
// class AuthUser {
//   String? accessToken;
//   User? user;

//   AuthUser({
//     this.accessToken,
//     this.user,
//   });

//   AuthUser.fromJson(Map<String, dynamic> json) {
//     accessToken = json['accessToken'];
//     user = json['user'] != null ? User.fromMap(json['user']) : null;
//   }



//   @override
//   String toString() => 'AuthUser(accessToken: $accessToken, user: $user)';

//   @override
//   bool operator ==(covariant AuthUser other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.accessToken == accessToken &&
//       other.user == user;
//   }

//   @override
//   int get hashCode => accessToken.hashCode ^ user.hashCode;
// }
