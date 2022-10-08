import 'package:chat_app/presentation/res/colors.dart';
import 'package:chat_app/presentation/res/dimentions.dart';
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
      _textTitle = 'Email';
      _iconField = const Icon(Icons.email, color: Colors.white);
      _hintText = 'Enter your Email';
    } else if (widget.isPassword) {
      _textTitle = 'Password';
      _iconField = const Icon(Icons.lock, color: Colors.white);
      _hintText = 'Enter your Password';
    } else {
      _textTitle = 'Verify';
      _iconField =
          const Icon(Icons.verified_user_outlined, color: Colors.white);
      _hintText = 'Re-enter your Password';
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
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: Dimensions.height10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: customPurple,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: Dimensions.height60,
          child: TextField(
            onChanged: (value) => widget.onChanged(value),
            onSubmitted: widget.onSubmitted,
            controller: _controller,
            keyboardType: widget.isEmail
                ? TextInputType.emailAddress
                : TextInputType.multiline,
            obscureText: !widget.isEmail ? true : false,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: Dimensions.height14),
              prefixIcon: _iconField,
              hintText: _hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
