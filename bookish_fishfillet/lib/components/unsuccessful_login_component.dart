import 'package:bookish_fishfillet/components/auth_component.dart';
import 'package:flutter/material.dart';

class LoginFailureComponent extends StatefulWidget {
  const LoginFailureComponent({super.key});

  @override
  State<LoginFailureComponent> createState() => _LoginFailureComponentState();
}

class _LoginFailureComponentState extends State<LoginFailureComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sign-in Unsuccessful'),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const AuthComponent()),
                    );
                  },
                  child: const Text("LOGIN AGAIN"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
