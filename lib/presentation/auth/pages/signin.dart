import 'package:finku/common/helper/navigation/app_navigation.dart';
import 'package:finku/core/configs/theme/app_colors.dart';
import 'package:finku/presentation/auth/pages/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reactive_button/reactive_button.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signinText(),
            const SizedBox(height: 30,),
            _emailField(),
            const SizedBox(height: 20,),
            _passwordField(),
            const SizedBox(height: 60,),
            _signinButton(),
            const SizedBox(height: 20,),
            _signupText(context)
          ],
        )
        ),
    );
  }

  Widget _signinText() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24
      ),
      );
  }

  Widget _emailField() {
    return const TextField(
      decoration: InputDecoration(
        hintText: "Email"
      ),
    );
  }

  Widget _passwordField() {
    return const TextField(
      decoration: InputDecoration(
        hintText: "Password"
      ),
    );
  }

  Widget _signinButton() {
    return ReactiveButton(
      title: 'Sign In',
      activeColor: AppColors.primary,
      onPressed: () async {},
      onSuccess: () {},
      onFailure: (error) {}
      );
  }

  Widget _signupText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Apakah kamu tidak punya akun?'
            ),
          TextSpan(
            text: ' Sign Up',
            style: const TextStyle(
              color: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()..onTap = (){
              AppNavigator.push(context, const SignupPage());
            }
            ),
        ]
      )
    );
  }
}