class ChatRoom {
  String? sId;
  List<String>? users;
  String? lastMessage;
  String? typeLastMessage;
  String? timeLastMessage;
  int? iV;

  ChatRoom({
    this.sId,
    this.users,
    this.lastMessage,
    this.typeLastMessage,
    this.timeLastMessage,
    this.iV,
  });

  ChatRoom.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    users = json['users'].cast<String>();
    lastMessage = json['lastMessage'];
    typeLastMessage = json['typeLastMessage'];
    timeLastMessage = json['timeLastMessage'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['users'] = users;
    data['lastMessage'] = lastMessage;
    data['typeLastMessage'] = typeLastMessage;
    data['timeLastMessage'] = timeLastMessage;
    data['__v'] = iV;
    return data;
  }
}
