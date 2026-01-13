import 'package:flutter/material.dart';

class login_button extends StatefulWidget {
  const login_button({super.key});

  @override
  State<login_button> createState() => _login_buttonState();
}

class _login_buttonState extends State<login_button> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('login_button is working'),
      ),
    );
  }
}
