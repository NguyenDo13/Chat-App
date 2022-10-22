// import 'package:chat_app/presentation/res/colors.dart';
// import 'package:chat_app/presentation/res/dimentions.dart';
// import 'package:chat_app/presentation/services/chat_bloc/chat_bloc.dart';
// import 'package:chat_app/presentation/services/chat_bloc/chat_event.dart';
// import 'package:chat_app/presentation/services/chat_bloc/chat_state.dart';
// import 'package:chat_app/presentation/widgets/input_text_field_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';

// AppBar buildAppbar({
//   required BuildContext context,
//   required bool isDarkMode,
//   required Function() onDelete,
//   required Function(String) onSubmit,
// }) {
//   return AppBar(
//         toolbarHeight: Dimensions.height72,
//         leading: BlocBuilder<ChatBloc, ChatState>(
//       builder: (context, state) {
//         return IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Provider.of<ChatBloc>(context, listen: false).add(ExitFriendEvent());
//           },
//         );
//       },
//     ),
//         title: BlocBuilder<ChatBloc, ChatState>(
//           builder: (context, state) {
//             return TextFieldWidget(
//               hintText: 'Nhập địa chỉ email',
//               padding: 0,
//               boxDecorationColor:
//                   isDarkMode ? blackDarkMode! : Colors.white,
//               onChanged: (value) {},
//               onDeleted: onDelete,
//               onSubmitted: (value){
//                 FocusScope.of(context).unfocus();
//             setState(() {
//               stateAddFriend = true;
//             });
//             Provider.of<ChatBloc>(context, listen: false).add(
//               OrderPersonEvent(words: value),
//             );
//               },
//               suffixIconColor: isDarkMode ? Colors.white : Colors.black,
//             );
//           },
//         ),
//       );
// }
