//Setting screen
String takeLetters(String name) {
  String letterA = '';
  String letterB = '';
  //+ Kiểm tra khoảng trắng
  final words = name.split(' ');
  //* lấy 2 từ cuối cùng
  if (words.length == 1) {
    letterA = words[0][0];
  } else if (words.length == 2) {
    letterA = words[0][0];
    letterB = words[1][0];
  } else {
    letterA = words[words.length - 3][0];
    letterB = words[words.length - 2][0];
  }
  return'$letterA$letterB'.toUpperCase();
}
