import 'package:chat_app/presentation/UIData/app_content.dart';
import 'package:chat_app/presentation/UIData/images_animations.dart';
import 'package:chat_app/presentation/UIData/style.dart';
import 'package:chat_app/presentation/widgets/button_round_white.dart';
import 'package:chat_app/presentation/widgets/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: DecorationBGLogin,
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                          height: MediaQuery.of(context).size.width - 120,
                          child: Lottie.asset(
                            JSON_SIGNUP,
                            fit: BoxFit.fitWidth,
                          )
                          // decoration: ,
                          ),
                      const Text(
                        TITLE_SIGNUP,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      InputTextField(isEmail: true, onChanged: (email) {}),
                      const SizedBox(height: 20.0),
                      InputTextField(
                        isPassword: true,
                        onChanged: (pass) {},
                      ),
                      const SizedBox(height: 10.0),
                      ButtonRoundWhite(
                        textButton: TITLE_SIGNUP,
                        press: () {      },
                      ),
                      _buildSignupBtn(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: IF_HAVE_ACC,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: TITLE_LOGIN,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
