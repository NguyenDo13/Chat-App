import 'package:chat_app/presentation/UIData/app_content.dart';
import 'package:chat_app/presentation/UIData/style.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final Function(String)? onSubmitted;
  final Function(String) onChanged;
  final bool isEmail;
  final bool isPassword;

  const InputTextField({
    Key? key,
    this.isEmail = false,
    this.isPassword = false,
    this.onSubmitted,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  late final TextEditingController _controller;
  late String _textTitle;
  late String _hintText;
  late Icon _iconField;

  @override
  void initState() {
    _iconField = const Icon(Icons.error);
    if (widget.isEmail) {
      _textTitle = EMAIL;
      _iconField = const Icon(Icons.email, color: Colors.white);
      _hintText = ENTER_EMAIL;
    } else if (widget.isPassword) {
      _textTitle = PASS;
      _iconField = const Icon(Icons.lock, color: Colors.white);
      _hintText = ENTER_PASS;
    }
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _textTitle,
          style: LabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (value) {
              widget.onChanged(value);
            },
            onSubmitted: widget.onSubmitted,
            controller: _controller,
            keyboardType: widget.isEmail == true
                ? TextInputType.emailAddress
                : TextInputType.multiline,
            obscureText: widget.isPassword == true ? true : false,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: _iconField,
              hintText: _hintText,
              hintStyle: HintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
