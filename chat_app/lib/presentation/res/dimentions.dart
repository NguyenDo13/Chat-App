import 'dart:math';
import 'package:get/get.dart';

class Dimensions {
  //screen
  static double screenHeight = Get.context!.height; //856.727272
  static double screenWidth = Get.context!.width; //392.727272
  static double screenInch = sqrt(screenHeight * screenHeight +
      screenWidth * screenWidth); //942.4522961818876

  //hieght
  static double height2 = screenHeight / 428.36;
  static double height4 = screenHeight / 214.18;
  static double height6 = screenHeight / 142.7866667;
  static double height8 = screenHeight / 107.09;
  static double height9 = screenHeight / 95.191111;
  static double height10 = screenHeight / 85.67;
  static double height12 = screenHeight / 71.39;
  static double height13 = screenHeight / 65.901538;
  static double height14 = screenHeight / 61.19;
  static double height16 = screenHeight / 53.545;
  static double height18 = screenHeight / 47.59555556;
  static double height19 = screenHeight / 45.09;
  static double height20 = screenHeight / 42.84;
  static double height24 = screenHeight / 35.6966667;
  static double height25 = screenHeight / 34.26909088;
  static double height30 = screenHeight / 28.557;
  static double height32 = screenHeight / 26.77;
  static double height36 = screenHeight / 23.8;
  static double height40 = screenHeight / 21.42;
  static double height44 = screenHeight / 19.47;
  static double height48 = screenHeight / 17.85;
  static double height60 = screenHeight / 14.27866667;
  static double height62 = screenHeight / 13.818;
  static double height72 = screenHeight / 11.9;
  static double height120 = screenHeight / 7.139333333;
  static double height220 = screenHeight / 3.89418;

  //width
  static double width2 = screenWidth / 196.363636;
  static double width8 = screenWidth / 49.09090909;
  static double width9 = screenWidth / 43.63636356;
  static double width10 = screenWidth / 39.2727272;
  static double width12 = screenWidth / 32.72727267;
  static double width14 = screenWidth / 28.051948;
  static double width16 = screenWidth / 24.5454545;
  static double width19 = screenWidth / 20.66985642;
  static double width25 = screenWidth / 15.70909088;
  static double width44 = screenWidth / 8.925619818;
  static double width62 = screenWidth / 6.33431;
  static double width72 = screenWidth / 5.454545444;
  static double width120 = screenWidth / 3.272727267;
  static double width144 = screenWidth / 2.727272722;
  static double width152 = screenWidth / 2.583732053;
  static double width220 = screenWidth / 1.785123964;
  static double width250 = screenWidth / 1.570909088;

  //radius - font size - icon size
  static double double12 = screenInch / 78.53769134;
  static double double13 = screenInch / 72.49633047;
  static double double14 = screenInch / 67.31802115;
  static double double15 = screenInch / 62.83015307;
  static double double16 = screenInch / 58.90326851;
  static double double30 = screenInch / 31.41507654;
  static double double36 = screenInch / 26.17923045;
  static double double40 = screenInch / 23.5613074;
}
