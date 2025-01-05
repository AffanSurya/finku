import 'package:flutter/material.dart';

class SiginPage extends StatelessWidget {
  const SiginPage({super.key});

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
            _emailField()
          ],
        )
        ),
    );
  }

  Widget _signinText(){
    return const Text(
      'Sign In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24
      ),
      );
  }

  Widget _emailField(){
    return const TextField(
      decoration: InputDecoration(
        hintText: "Email"
      ),
    );
  }
}