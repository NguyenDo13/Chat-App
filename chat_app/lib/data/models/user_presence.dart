// ignore_for_file: prefer_collection_literals

class UserPresence {
  String? sId;
  String? userID;
  bool? presence;
  int? iV;

  UserPresence({this.sId, this.userID, this.presence, this.iV});

  UserPresence.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userID = json['userID'];
    presence = json['presence'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['userID'] = userID;
    data['presence'] = presence;
    data['__v'] = iV;
    return data;
  }
}