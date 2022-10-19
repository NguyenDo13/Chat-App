import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
import 'package:chat_app/presentation/widgets/input_text_field_search.dart';
import 'package:flutter/material.dart';

AppBar buildAppbar({
  required bool isDarkMode,
  required Function(String) onChange,
  required Function(String) onSubmit,
}) {
  return AppBar(
    toolbarHeight: Dimensions.height72,
    title: TextFieldWidget(
      hintText: 'Nhập tên người mà bạn muốn tìm',
      padding: 0,
      boxDecorationColor: isDarkMode ? blackDarkMode! : Colors.white,
      onChanged: (value) => onChange(value),
      onDeleted: () {},
      onSubmitted: (value) => onSubmit(value),
      suffixIconColor: isDarkMode ? Colors.white : Colors.black,
    ),
  );
}
