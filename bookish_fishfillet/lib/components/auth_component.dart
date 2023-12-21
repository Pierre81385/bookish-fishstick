import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './Authentication.dart';
import 'successful_login_component.dart';
import 'unsuccessful_login_component.dart';
import 'validator.dart';

class AuthComponent extends StatefulWidget {
  const AuthComponent({super.key});

  @override
  State<AuthComponent> createState() => _AuthComponentState();
}

class _AuthComponentState extends State<AuthComponent> {
  final _loginFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passwordVerificationTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusPasswordVerification = FocusNode();

  bool _register = false;

  void result(user) {
    user != null
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => LoginSuccessComponent(user: user)),
          )
        : Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const LoginFailureComponent()),
          );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          _focusName.unfocus();
          _focusEmail.unfocus();
          _focusPassword.unfocus();
          _focusPasswordVerification.unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _register ? const Text('NEW USER') : const Text('LOGIN'),
            Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    height: _register ? 100 : 0.0,
                    width: _register ? width : 0.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    // Define how long the animation should take.
                    duration: const Duration(milliseconds: 250),
                    // Provide an optional curve to make the animation feel smoother.
                    curve: Curves.fastOutSlowIn,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _nameTextController,
                        focusNode: _focusName,
                        validator: (value) => Validator.validateName(
                          name: value,
                        ),
                        decoration: InputDecoration(
                            labelText: 'Username',
                            icon: _register ? const Icon(Icons.person) : null),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _emailTextController,
                      focusNode: _focusEmail,
                      validator: (value) => Validator.validateEmail(
                        email: value,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _passwordTextController,
                      focusNode: _focusPassword,
                      validator: (value) => Validator.validatePassword(
                        password: value,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        icon: Icon(Icons.key),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    height: _register ? 100 : 0.0,
                    width: _register ? width : 0.0,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    // Define how long the animation should take.
                    duration: const Duration(milliseconds: 250),
                    // Provide an optional curve to make the animation feel smoother.
                    curve: Curves.fastOutSlowIn,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _passwordVerificationTextController,
                        focusNode: _focusPasswordVerification,
                        validator: (value) => Validator.validatePassword(
                          password: value,
                        ),
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            icon: _register ? const Icon(Icons.key) : null),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {
                            _focusName.unfocus();
                            _focusEmail.unfocus();
                            _focusPassword.unfocus();
                            _focusPasswordVerification.unfocus();
                            setState(() {
                              _register = !_register;
                            });
                          },
                          child: _register
                              ? const Text("Back to Login")
                              : const Text('Register New User'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () async {
                            _focusName.unfocus();
                            _focusEmail.unfocus();
                            _focusPassword.unfocus();
                            _focusPasswordVerification.unfocus();
                            if (_register) {
                              User? user = await Authentication
                                  .registerUsingEmailPassword(
                                      name: _emailTextController.text,
                                      email: _emailTextController.text,
                                      password: _passwordTextController.text);
                              user =
                                  await Authentication.signInUsingEmailPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text,
                              );
                              _nameTextController.text = "";
                              _emailTextController.text = "";
                              _passwordTextController.text = "";
                              _passwordVerificationTextController.text = "";
                              result(user);
                            } else {
                              User? user =
                                  await Authentication.signInUsingEmailPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text,
                              );
                              _nameTextController.text = "";
                              _emailTextController.text = "";
                              result(user);
                            }
                          },
                          child: const Text("Submit"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
