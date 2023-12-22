import 'package:bookish_fishfillet/components/Authentication.dart';
import 'package:bookish_fishfillet/components/auth_component.dart';
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('UID: ${_user.uid}'),
            Text('Display Name: ${_user.displayName}'),
            Text('Email Address: ${_user.email}'),
            _user.emailVerified
                ? const Text('Email Verified')
                : OutlinedButton(
                    onPressed: () {
                      _user.sendEmailVerification();
                    },
                    child: const Text('Send Email Verification')),
            IconButton(
                onPressed: () {
                  Authentication.signoutUser(_user);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => AuthComponent()));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
