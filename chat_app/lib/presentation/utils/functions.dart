//Setting screen
import 'package:intl/intl.dart';

String takeLetters(String name) {
  String letterA = '';
  String letterB = '';

  final words = name.split(' ');

  if (words.length == 1) {
    letterA = words[0][0];
  } else if (words.length == 2) {
    letterA = words[0][0];
    letterB = words[1][0];
  } else {
    letterA = words[words.length - 3][0];
    letterB = words[words.length - 2][0];
  }
  return '$letterA$letterB'.toUpperCase();
}

// Home screen
String formatTime(String time) {
  final currentTime = DateFormat('kk:mm dd/MM/yyyy').format(DateTime.now());

  final checkArrayTime = time.split("/");
  final currentArrayTime = currentTime.split('/');

  //Check year
  final checkYear = int.parse(checkArrayTime[2]);
  final currentYear = int.parse(currentArrayTime[2]);

  //Check month
  final checkMonth = int.parse(checkArrayTime[1]);
  final currentMonth = int.parse(currentArrayTime[1]);

  if (checkYear < currentYear) {
    return "$checkMonth/$checkYear";
  }

  final checkArrayDate = checkArrayTime[0].split(" ");
  final currentArrayDate = currentArrayTime[0].split(" ");
  //Check date
  final checkDate = int.parse(checkArrayDate[1]);
  final currentDate = int.parse(currentArrayDate[1]);

  if (checkMonth < currentMonth || checkDate < currentDate) {
    return "$checkDate/$checkMonth";
  }
  return checkArrayDate[0];
}

String formatDay(String time) {
  final currentTime = DateFormat('kk:mm dd/MM/yyyy').format(DateTime.now());

  final checkArrayTime = time.split("/"); // 10:30 24, 10, 2022
  final currentArrayTime = currentTime.split('/');

  final checkYear = int.parse(checkArrayTime[2]);
  final currentYear = int.parse(currentArrayTime[2]);

  final checkMonth = int.parse(checkArrayTime[1]);
  final currentMonth = int.parse(currentArrayTime[1]);

  final checkArrayDate = checkArrayTime[0].split(" ");
  final currentArrayDate = currentArrayTime[0].split(" ");
  final checkDate = int.parse(checkArrayDate[1]);
  final currentDate = int.parse(currentArrayDate[1]);

  if (checkYear < currentYear) {
    return "$checkDate/$checkMonth/$checkYear";
  }

  if (checkMonth < currentMonth) {
    return customTimeResult(checkMonth, currentMonth, "tháng trước");
  }

  if (checkDate < currentDate) {
    return customTimeResult(checkDate, currentDate, "ngày trước");
  }

  final checkArrayHour = checkArrayDate[0].split(":"); // hh, min
  final currentArrayHour = currentArrayDate[0].split(":");
  final checkHour = int.parse(checkArrayHour[1]);
  final checkMin = int.parse(checkArrayHour[0]);
  final currentHour = int.parse(currentArrayHour[1]);
  final currentMin = int.parse(currentArrayHour[0]);

  if (checkHour < currentHour) {
    return customTimeResult(checkHour, currentHour, "giờ trước");
  }

  if (checkMin < currentMin) {
    return customTimeResult(checkMin, currentMin, "phút trước");
  }
  return "vài giây trước";
}

String customTimeResult(int check, int current, String custom) {
  int result = current - check;
  return "$result $custom";
}
