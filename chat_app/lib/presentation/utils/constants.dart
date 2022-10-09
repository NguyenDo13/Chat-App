// ignore_for_file: constant_identifier_names
import 'package:chat_app/presentation/pages/groups/group_chat.dart';
import 'package:chat_app/presentation/pages/home/home_screen.dart';
import 'package:chat_app/presentation/pages/calls/calls_screen.dart';
import 'package:chat_app/presentation/pages/setting/setting_screen.dart';
import 'package:flutter/material.dart';

const int maxValueInteger = 10000000;
const List<String> TITLES_PAGE = ['Đoạn chat', 'Nhóm', 'Cuộc gọi', 'Cá nhân'];

//* DS các trang cho navigation_bar
const List<Widget> pages = [
  HomeScreen(),
  GroupChatScreen(),
  CallsScreen(),
  SettingScreen()
];
