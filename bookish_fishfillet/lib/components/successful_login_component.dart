import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginSuccessComponent extends StatefulWidget {
  const LoginSuccessComponent({super.key, required this.user});
  final User user;

  @override
  State<LoginSuccessComponent> createState() => _LoginSuccessComponentState();
}

class _LoginSuccessComponentState extends State<LoginSuccessComponent> {
  late User _user;
  @override
  void initState() {
    _user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
