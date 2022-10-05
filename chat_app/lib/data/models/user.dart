// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? sId;
  String username;
  String? email;
  String? password;
  bool? isDarkMode;
  String avatar;
  bool state;
  User({
    this.sId,
    required this.username,
    this.email,
    this.password,
    this.isDarkMode,
    required this.avatar,
    required this.state,
  });
}


// ignore: non_constant_identifier_names
List<dynamic> LIST_USERS = [
  [
    User(username: "Nguyễn Trường Sinh", avatar: 'user1.jpg', state: true,),
    'Ban: Hello, world!',
    '12:00',
  ],
  [
    User(username: "Nguyễn Dộ", avatar: 'user2.jpg', state: true,),
    'Ban: Hello, world!',
    '12:00',
  ],
  [
    User(username: "Đại Ác Ma", avatar: 'user3.jpg', state: false,),
    'Bạn: Hello, Peter!',
    '12:00',
  ],
  [
    User(username: "Đại Ác Ma", avatar: 'user4.jpeg', state: false,),
    "Xì nêeeeeeeeeee!",
    '12:00',
  ],
  [
    User(username: "Ma Vương", avatar: 'user3.jpg', state: false,),
    "Ma Vương tới chơi :D!",
    '12:00',
  ],
  [
    User(username: "Đại Ác Ma", avatar: 'user4.jpeg', state: false,),
    'Ban: Hello, world!',
    '12:00',
  ],
  [
    User(username: "Đại Ác Ma", avatar: 'user4.jpeg', state: false,),
    'Ban: Hello, world!',
    '12:00',
  ],
  [
    User(username: "Đại Ác Ma", avatar: 'user4.jpeg', state: false,),
    'Ban: Hello, world!',
    '12:00',
  ],
  [
    User(username: "Đại Ác Ma", avatar: 'user4.jpeg', state: false,),
    'Ban: Hello, world!',
    '12:00',
  ],
  [
    User(username: "Đại Ác Ma", avatar: 'user4.jpeg', state: false,),
    'Ban: Hello, world!',
    '12:00',
  ],
  [
    User(username: "Đại Ác Ma", avatar: 'user4.jpeg', state: false,),
    'Ban: Hello, world!',
    '12:00',
  ],
  [
    User(username: "Đại Ác Ma", avatar: 'user4.jpeg', state: false,),
    'Ban: Hello, world!',
    '12:00',
  ],
];
