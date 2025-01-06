import 'package:finku/common/helper/navigation/app_navigation.dart';
import 'package:finku/core/configs/theme/app_colors.dart';
import 'package:finku/presentation/auth/pages/signin.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reactive_button/reactive_button.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _signupText(),
            const SizedBox(height: 30,),
            _emailField(),
            const SizedBox(height: 20,),
            _passwordField(),
            const SizedBox(height: 60,),
            _signupButton(),
            const SizedBox(height: 20,),
            _signinText(context)
          ],
        )
        ),
    );
  }

  Widget _signupText() {
    return const Text(
      'Sign Up',
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

  Widget _signupButton() {
    return ReactiveButton(
      title: 'Sign Up',
      activeColor: AppColors.primary,
      onPressed: () async {},
      onSuccess: () {},
      onFailure: (error) {}
      );
  }

  Widget _signinText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
            text: 'Apakah kamu tidak punya akun?'
            ),
          TextSpan(
            text: ' Sign In',
            style: const TextStyle(
              color: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()..onTap = (){
              AppNavigator.push(context, const SigninPage());
            }
            ),
        ]
      )
    );
  }
}