import 'package:flutter/material.dart';

class login_form extends StatefulWidget {
  const login_form({super.key});

  @override
  State<login_form> createState() => _login_formState();
}

class _login_formState extends State<login_form> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('login_form is working'),
      ),
    );
  }
}
