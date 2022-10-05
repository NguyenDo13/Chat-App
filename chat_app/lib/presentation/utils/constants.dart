// ignore_for_file: constant_identifier_names

import 'package:chat_app/presentation/screens/calls/calls_screen.dart';
import 'package:chat_app/presentation/screens/home/home_screen.dart';
import 'package:chat_app/presentation/screens/setting/setting_screen.dart';
import 'package:chat_app/presentation/screens/stories/stories_screen.dart';
import 'package:flutter/material.dart';

const int maxValueInteger = 10000000;
const List<String> TITLES_PAGE = ['Đoạn chat', 'Cuộc gọi', 'Tin', 'Cá nhân'];

//* DS các trang cho navigation_bar
const List<Widget> pages = [
  HomeScreen(),
  CallsScreen(),
  StoriesScreen(),
  SettingScreen(),
];
